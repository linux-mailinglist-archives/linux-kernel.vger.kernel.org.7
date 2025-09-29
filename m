Return-Path: <linux-kernel+bounces-836064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F85ABA8A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FED716AD95
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A9028C5D5;
	Mon, 29 Sep 2025 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="wE0s3H77"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022116.outbound.protection.outlook.com [40.107.75.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04089280339;
	Mon, 29 Sep 2025 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138305; cv=fail; b=cWVo9wpDUCKO5XEiWBQlfOBQ0wDIk9L2QHmk+bOToAK/cZ41KATYbhcbHq8vRluJGjVykp/tO0wGsNPQg9/YdONLtIEpEZsmQzcWnJLdHGRgixtFrMVl5PXIRZ0itdycFLlxdtOj324jtCzvqxwxoZNXkkwAJrRH/psUccxdqhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138305; c=relaxed/simple;
	bh=Ybh5WQEUYIlSvSBAm1aAo8b7rr8QP2Er3fDUjbx7suY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sj6KQSjMjqBcEuKvbJ4PJvhS+w0vhzlzl2eecYqpSi/5E3J3KfZ3Y5ICu/x7VR5MG/c6Bvz7TFhHPx+ream3bVW2o7ngmxbNB7wJzAVeVQ64kN/DX5dLnJpf24YrohEk29Ytydhd1pFOYB5GSHYLHlhDitsE7+NY4fcKSQuqU1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=wE0s3H77; arc=fail smtp.client-ip=40.107.75.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=La0cnvT4cYOzJPWL/ihImE5wZLCbK/Bc/BeyhnxzD+/3Sk1EO7eInLgw1p8qZisxIMLxe6XAHQFx2XQQ6ahoWZNyaOLLRqkyBaFC7rWjRdMcepzNeqTXFyhcaNofdAlL0I5gu69kzpET86nEEghQ9Zt2TVFqKsVUc7yYniN+NSYFWiLQYVgZD78XcpBjreD0P6byeSd6Yoag7h30ZIwtJDOo6rToHeS8ZcEIYBS5yZsLwcYHL7VufCQio56gfY4s71RachSq3Ql5GkIwqxoOxptgaZXJ7MjgA6DwqrNpv9V3O0jdp5I1eF2ItzZLLekYFhFVCe5xPhcXu0ly6CoMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6js61FF3XzIpiviMctRcf9MyKu6wVA9+NNyDgU9sXY=;
 b=ngsPTAtpgpAgC/IxLwHAXaHC/E5kpL5PEOLC+PMcevQoYVG3sisFJVVZB2Wgoyed2OPdrA+qYbtlOm79K3c6pVOUQxWpe6upObZI9UxOsvQ8qNwt/GMvUpbhzRC6+oU/8RIqZB+c8LBm29rozbyRWIz/E7HcGGwsKXJHYHg2vPtzrIV1xNiK3EM7D/gWZHZ1TWxPIj9EnSfUvLEdX/vusAIZ/TKxb1muiQq7NbieYF8Sg5urKg1mFIKYFhkNNHOz85hmZzuJc7Qt3Q0cg8Xh1f7HN4GxeprYleXevlTfRUqXqdGNMC27/GJH91a6iC5HkPdI2NStXdkZQAmyzKh4iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6js61FF3XzIpiviMctRcf9MyKu6wVA9+NNyDgU9sXY=;
 b=wE0s3H77GDgIg4c2zuh/UDzsC28EBZygKQ4ko4AcGXBfcHEnY69XP5j1BJx0LWQ1MndtoS8d3DM7c3WrzXHCOpFWxv33hwz/YtZLWqWAP/kxKS3iNE8nyb00cCjz4tKm8/85SrYickZL9Wm3H6d7hfBCpJZGC54RkgmFnzRb8x377/wIEv8/qWL653KSKsHHxYhj0/k+M4/cpwWqKOgX8wX1STzfUtIgp8AXu2WiEjSsrs/WkDIHt27BoRp+f1Xy36VB5ElZuevB6KNwxq4F/U5WmMmIJ+rRj7FpPZJYjcvrU7giteXnM9Wv0Rq+lUblg/RF36NBVzzc5B6zhL/S+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by TYZPR03MB7576.apcprd03.prod.outlook.com (2603:1096:400:427::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Mon, 29 Sep
 2025 09:31:40 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e%5]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 09:31:40 +0000
Message-ID: <36cd6282-ae1d-43f3-8738-592f043d0ba6@amlogic.com>
Date: Mon, 29 Sep 2025 17:31:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clk: meson: Fix glitch free mux related issues
To: Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <20240929-fix_glitch_free-v1-0-22f9c36b7edf@amlogic.com>
 <20240929-fix_glitch_free-v1-2-22f9c36b7edf@amlogic.com>
 <CAFBinCBd5-s6vaBoJNerXavQiHgsv4Fm3v0svUX7geL=kJvVYg@mail.gmail.com>
 <20178015-4075-40e9-bbf4-20ae558c2bef@amlogic.com>
 <1jldyzrv2t.fsf@starbuckisacylon.baylibre.com>
 <e70e9aaa-f448-4f67-9149-cb5970c9bbd6@amlogic.com>
 <9834c7c5-9334-4c78-a2fe-588ff03cf935@amlogic.com>
 <CAFBinCCoX5+6+KQAtbhKx9KdSZhXVxS=cz8DfMVhjPX1c0iSPw@mail.gmail.com>
 <1jfrc563wa.fsf@starbuckisacylon.baylibre.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1jfrc563wa.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|TYZPR03MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: f639bc76-1b94-440e-e445-08ddff3afecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2M4TTA0dHdXcXNhaEVhRjBXZVlhNXFvL01qTXVTVXhQRlVudzhuL3ZjZzla?=
 =?utf-8?B?azRnK2xVVXp1ZHdLUXpqdU1lNEN0UEdxM1BhMTJydkJMcFJhb2x6OVRidm1w?=
 =?utf-8?B?YzFmV1A0N0pVVmY1KzRqa0VOZlpvVnNNVEV3SSthSDlhZ2lERUVmUWdKbFhy?=
 =?utf-8?B?UGtpT0MwVk44a1NYYkZHajQrUnZoZUQvUlo4dVJlK1V2NWZtVGZlcVFyWXhw?=
 =?utf-8?B?MWhQanA1NEdKdkl5cGg3MHoyYkdScnB5WWMzamtBWXlFL2pzZTFURWt5ME15?=
 =?utf-8?B?TDNnZXN2Si9ONzlVSDY1WExRem5BcjZ5bDV4V0dVSjBmeUhaTEcwdTRiZE00?=
 =?utf-8?B?dzMyRDFUUEZxbjF1aVM3L24xWWVzUDd6Yy9FaU8vdCs2K2FMczZMSmxiTG56?=
 =?utf-8?B?ZzRQWFFJZlZJemZ6ZXpJRFR2c3JMamRUZ0hCRFNsUkVNdVdMaXRIWlhVM3pv?=
 =?utf-8?B?NkcrMms4NnV4M2F4L2M3amlCYU9tak1DcVcyNC9yUloxdi9QeDAxVFk1dXRn?=
 =?utf-8?B?VUNUYkYzekVEOGlRZVdqa2ZaZGRsNkdGc3NtSWFGcmJnVC8vc0VKZGdvVDhV?=
 =?utf-8?B?V0EzbnlnRjJnQVJBSWtwWU9BbWVOUkpmM0FkOWIyRHFQNzZXWGFHTGFOUmNT?=
 =?utf-8?B?ekNIMzI3MWJxWnBoeThkOHFoRzdlZTVwUDczN0VBd2dIUGwvTXN3cVdLYUNJ?=
 =?utf-8?B?ZEN2SG51OGp5VXQwcE5NdVhYeUpJYi84WnJtRStQRTlXWWErenhWWHgzbTEy?=
 =?utf-8?B?b3BrbS9SSWp1MlZnUkxGbCs2WkJEQWM1WThyN3RjazNRYTVsMUMvQWxKZTRK?=
 =?utf-8?B?WnhrUHFTQU8yUDR1RmN4bXU1eWY0dlhWRnByN0VYNTdnaFBQRzBDMCs4a04r?=
 =?utf-8?B?Z0xtVjhLS3dCZ2E4UzVVci85L2RIVXgxdVNsZHlOa0c0Y2s3dEVONUdBT21W?=
 =?utf-8?B?U2Q5YW5SVzdtUmdOVFU3RjBiVDF2MWRoSkdZVHZZOFlpM0hkUG02ZFFzbWZa?=
 =?utf-8?B?MGY2VWllbjhOcFQ5bFVnR1FOczlHUFBDemVlL1dBRFhZK21nZk1rVGo2d0tq?=
 =?utf-8?B?TGFxQVN1L282SlRMbGY5QXBrNXN5a0tpRm12alRCY1FmaTM5Vk5temFSNDVQ?=
 =?utf-8?B?WlV3MHg0dHBsc3gzZ1hsUWtxUjJDM3M3aFpodHBRbGpQbE9zUzRsbHIrd3dt?=
 =?utf-8?B?R3pPQXZZM2d5WWdQdWFvQ1VVM2lBeTRDRS9ZSERkZEhzWFpxcWcrbHNqWG0y?=
 =?utf-8?B?K3RaUEZQaktMVldVeExOVEU4TGh2WEZ3a1pSYkxOMy9pQUxyQU5tTUlqaDlr?=
 =?utf-8?B?Ykpxb0RsMmQ1bXc2Yjk4Zm0vOE8zQ29PTE5jcUtWejIxWlFLS1Z1UzJ5Q1Ay?=
 =?utf-8?B?UWlXMyswcTU1NEIxbXhtRm81djhQaUk5L2Zqend4Y3NLcmh3WjN4aUlrbit2?=
 =?utf-8?B?RDAzTTV2K2RCVWRPdWRvdUNNa2oza2oxRGxka3AxQjVoVmJad0ZoRGI0eUNB?=
 =?utf-8?B?bk43T3pFY3pIN0ZCeUk2Z3FNeFBjdDlvTlJnU2VpRXdaNE5jKys3UFlsN21Z?=
 =?utf-8?B?RkFMdDIvWG1xYzlUZlV0elpzODA0VGxSRVQ2UGd5WFdDTFRuQ2wzWDdkWE5m?=
 =?utf-8?B?U3F1c1NMcWxRQmpvV2pvRGdGeE1RVlBVbEpsRFppQ3hPODJjbVp2NWdGR0ZR?=
 =?utf-8?B?S0pod1VxaXZ6K2Q0T3YyckFObk5WdjR0R3ZScGxvRlBWUEU0eEJLajNqMHNy?=
 =?utf-8?B?VkROaGxkZGQvbmFzTCtIMXd5QlF0WE56enR2UnVacm9Lb3pHS0xvTzdxNkc5?=
 =?utf-8?B?NktwZWxrVmpFaFF6UjFLWHRDM285UER4bi9ZTThaMEVQR0tHNmRHRFV0WVpS?=
 =?utf-8?B?eWltalk3TEhQOGFGNDBiU0VFeHUyd1ZIWFNjQnMzM3ZRZ0dQakxvRDlRL3Za?=
 =?utf-8?Q?7yacMEjALtviR4nr31VVzzP+FmW0eqec?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzd4MGUvOGxYOVprUWdVMUYvTUx6bkJtai9URlZ4bXlYMDhWSHFEWm94Y0Ra?=
 =?utf-8?B?Z0c4cFVJSDJSaC9VdVhTLzYvblJYQi9GY3g1MGlXUEJNT003WDV5bnErVmx6?=
 =?utf-8?B?RkFXMzYzc2p4cVZIMERZc0diU3pUN0JrckoxRUxtVk1RVmZGeXE3RStTRWVL?=
 =?utf-8?B?TzFnbHpFaHNVYlRRZW1kdWNzcHQ4VXA2d01aTmZHNjBBeVdNQnoxMDg5ZElG?=
 =?utf-8?B?K2cxTVNOY2c4ZmNFVDYzL1JBY0ZTaUhTc3Yyd1BhRE5Kc0FOWDBBVEY4c2hv?=
 =?utf-8?B?SzFwSmFtOEpBdUpidWQycVBtQkVLNXk2MlRlOTV3TFU4MW1tV1JBS3FHQ0tB?=
 =?utf-8?B?WFVWWGt0QjdkdkJFV2lPZmZNSUpTYVFJSlNUM1hvMUJKQytFbDhBU2JXeG16?=
 =?utf-8?B?Z3czcXFHQThmcDl6WW8zd20zSzE4VG9BSXpiMnBvZXRubGhES3dyT0E5dU0x?=
 =?utf-8?B?YWcyckxONWYwS2d0dEd1YW43WEF1S0hUazhrSmo0d2NURWhwZGV2U1pKNVZV?=
 =?utf-8?B?OGxkQVlSTXpYWW54TUVWSDVSWHRRcktNb2pzMUtDOWZ3ZUF2RFdYSERGSmlo?=
 =?utf-8?B?TmxQdjl6VHRIVnhqdG9FR0JuMVJZWVRESTNFY252UDUzbSs0Mnd1Y2xqYk9J?=
 =?utf-8?B?U3FRNnBpNTVqNVE2SXlNVGsvekxlYXlSc05qTXZqSFBjSGZiVCtqbVg0Y0JE?=
 =?utf-8?B?TGprbWxmSnpLcHB4dnU0RzRoMEh4c29McjMwZ0s4eE12N0hmcDVEVEFYQ25K?=
 =?utf-8?B?amVvMS9nL3U4cXlyU0F4RkI1TUIvVDJ4RUZvK1l4N21MZ0tFa2plc2FCTVpZ?=
 =?utf-8?B?Tm1rWWFFR3FPZnRhVUFxTFFpS0hRUitxa2RieGJUbXd1VTRBZWxXYVBhbUpt?=
 =?utf-8?B?TkhGVzZRdTlROGFFVVFqQVFKbStPa0xsd1hSeVJsRHgzY2JUeXFQVEl2ckto?=
 =?utf-8?B?NlFSdFpNS1U5UGt4M0dRcHh0QkNQc3pXU0FuSFRJaWJicFl1bzdLb1V4R0JW?=
 =?utf-8?B?c3MzbFNTT0s4bzllZHN1U05LNFdtTkcyK1l0TFhKa3FpVXY5ZGdQcUxXRFY3?=
 =?utf-8?B?M1ovYVh3eTlyZEwxZ1hZY0lnZ2tvOVd0ZmJPcGFyd3BBdVN5SHZRVFQxZkFD?=
 =?utf-8?B?eXJEK0FKclZHWWptbGd6SHV6TVJ6NWxjMGx5THlxcXd0b2dlaHdiekpNVHJU?=
 =?utf-8?B?NDVKUXBXdFRwcGRuYjRPWXVLZzNkakVvTnNDanR1VTVHZFY2OUVqY3NlRzVt?=
 =?utf-8?B?SVpWelh4Z0h3NTFEb2c1YmZrc1ZnUHVSemNkOTM3UTloVTJOMmpGNWliMTFD?=
 =?utf-8?B?SGZmdm0rRG0yVTBaU2VlMUtaU0ZRVlZiK2VxVU13d29sL2RwRVNMQ1VVa3Bq?=
 =?utf-8?B?VjdhTkg2ZHJHYWZ6eUNRRU9iN0VRemdiS2V5ZzI3UzVyTEVOYjhQeXZ4SzV1?=
 =?utf-8?B?L1NMT0xBcHFmdmxGUnFpTmZpWGFmemkzVnFGYWdXWlJZQ2E0a0dpV0dpb25i?=
 =?utf-8?B?ZUQ3UFNsTlZLclFwZGNWaXQrbURxK3pNeVJPNmMrZmd5dmlYd3pTdkZmaDVN?=
 =?utf-8?B?QlR4M0tjcGd6bzlEUkxoWk8wY3JiNk5zbnFlUCs1VnBCb3AwREoxS0JhaHl4?=
 =?utf-8?B?c0tRSWc5MzNDemJ3ekplb1B5Vk9aYXpNV2VFc29hLzVqOVovNEZCQXg0SkhZ?=
 =?utf-8?B?R3dRN1Y3M2ZDbG1uZTdweHFYOEVIcE5MU1BvN1g4cXZGVVNGc0FSS2h3aFds?=
 =?utf-8?B?T1NPY0JnSUFKZXpxVGI3a2ZoYUgwTGdydVJzeUtVaUNIdGE2VVByRDlBYkkv?=
 =?utf-8?B?YlgveG9uenZjNi9Ra2lnV1laYm00Y3dpWWUvaXgvdUtTTXczUVBseFA1ZmJx?=
 =?utf-8?B?NC9FM0llS1BheWNzT3M5RkJlaDBHM3ZlVXpINlhUOHhpc0tNZUlzN3ZIRnNL?=
 =?utf-8?B?NENFR2xtVXpNQUZoZndFUkFjRGh6anQrWFEyTVpOeHpBMnlQZmtCOFpXa1lS?=
 =?utf-8?B?YkVHd3pXMk42ZHFMTWRqTEtFSlhtZ1ZOZHk0RGpQNm5PcEM5Z3BVay9TOVB0?=
 =?utf-8?B?M1lvaFhhc3BReHFWcmY2aWtRaXBqRitBcEI1ZFNIeDJLUXhaejhRQktZYzlX?=
 =?utf-8?Q?SNObewiR462tb7qBCjhTjxdH7?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f639bc76-1b94-440e-e445-08ddff3afecc
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 09:31:40.6490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yncgKn2wxgcez5we+oQ+bgV4DojWhzitfE6kRbYgqZTFrBUZVPK9Svm2Jf13OYeVWcLhUfZ+Dg/pswOU041Y9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7576


On 9/29/2025 4:48 PM, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
>
> On Sun 28 Sep 2025 at 22:55, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>
>> Hello,
>>
>> On Sun, Sep 28, 2025 at 8:41 AM Chuan Liu <chuan.liu@amlogic.com> wrote:
>>>
>>> On 9/28/2025 2:05 PM, Chuan Liu wrote:
>>>> Hi Jerome & Martin:
>>>>
>>>> Sorry for the imprecise description of the glitch-free mux earlier.
>>>>
>>>> Recently, while troubleshooting a CPU hang issue caused by glitches,
>>>> I realized there was a discrepancy from our previous understanding,
>>>> so I'd like to clarify it here.
>> [...]
>>> An example of the clock waveform is shown below:
>>>
>>>
>                       1                  2
>                       v                  v
>>>          __    __    __    __    __    __    __    __
>>> ori:  ↑  |__↑  |__↑  |__↑  |__↑  |__↑  |__↑  |__↑  |__↑
>>>                     ^
>>>                     1 * cycle original channel.
>>>          _   _   _   _   _   _   _   _   _   _   _   _
>>> new:  ↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑
>>>                                         ^
>>>                                         5 * cycles new channel.
>>>          __    __                        _   _   _   _
>>> out:  ↑  |__↑  |______________________↑ |_↑ |_↑ |_↑ |_↑
>>>                ^                        ^
>>>                start switching mux.     switch to new channel.
> Ok ... but when is it safe to disable the "ori" clock ?
> Can you do it at '1' already ? or do you have to wait for '2' ?


It should wait for "2", because there is a state machine in the
glitch-free mux, this state machine is driven by the working clock
provided by its channel 0.


>
>> Thank you for the detailed report!
>> This is indeed problematic behavior. I guess the result is somewhat
>> random: depending on load (power draw), silicon lottery (quality),
>> temperature, voltage supply, ... - one may or may not see crashes
>> caused by this.
>>
>> Based on the previous discussion on this topic, my suggestion is to
>> split the original patch:
>> - one to add CLK_SET_RATE_GATE where needed (I think the meson8b.c
>> driver already has this where needed) to actually enable the
>> glitch-free mux behavior
>> - another one with the CLK_OPS_PARENT_ENABLE change (meson8b.c would
>> also need to be updated) to prevent the glitch-free mux from
>> temporarily outputting an electrical low signal. Jerome also asked to
>> document the behavior so we don't forget why we set this flag
> Yes please split the changes and visit all the controllers shipping this
> type of muxes.
>
>> Both patches should get the proper "Fixes" tags.
> ... and proper fixes tag maybe different depending on the controller so
> there might more that just 2 changes.
>
>> I think it would also be great if you could include the waveform
>> example in at least the commit message as it helps understand the
>> problem.
>>
>> Let's also give Jerome some time to comment before you send patches.
>>
>>
>> Best regards,
>> Martin
> --
> Jerome

