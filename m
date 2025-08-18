Return-Path: <linux-kernel+bounces-773058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ABDB29AEA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E77AD7A9B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E02246BCD;
	Mon, 18 Aug 2025 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yiPyY+ka"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AA21D514E;
	Mon, 18 Aug 2025 07:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755502510; cv=fail; b=Q0PK4KkrhXkYZwrMD6u8bODuM7ELcq6lTm0Rymf9CG25KEBkUEBLNwn6NyqYBv+oqfoPJLVdS8SJW2cPbCZnuxtLwKKUycpJUV6Cuf/sy6Nt0nxC0vN3jcFhbcOlkW1gwkYWqmyieAL/nnDtKtwD9QAYejvl6upLq15vzAyesrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755502510; c=relaxed/simple;
	bh=uXi0lxeh1D4+VeJXg080ZGE8S0KDny3Lk6usp7hEnBQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nBPXeUbVDjzykWUiygu1jD8UvnqzmjphRQzY6IEOlrfGGWxkH3TyQWPAhXYQbeM/i8Ps7K9IWlinZ/IXYd58XfUvn1f2r+ftxvPRbxi/oLY/F1lL6IrrnKUIkdrW9kNT3ciMbHXD5OOejIyOVKLhZbijM2BH/ctIs53FniqhNV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yiPyY+ka; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRvZPpwUhhHnHR9yHpIel+VZ+EGEbCsG4DWWwzoKxpoFLxrIyxtC5t9JdykA7ykHxfcr+51DaoDnKJP5sMiukXDogpTf+nq3XhkXmQjLOwMaqmfJNMFthN0J+Aj+gOP9WzJPXUKc8fUrIgdX0+1xcXO/LI2rlEhPCJcYCwK0RNzI+Qs9oGiGpUWRLonyM82T4lBJVw8aHwyY1KFfG+2NK7aTduW31Ovfmtn4a6VSv1oRwJQ3uZAHhdWtA2/4POk2V2BB8GfIpYrFKndWJJ7RuGEuIQLAJbqsyKODjoKIlCnNXgZ0uCi905hjlL6i47754ZoNJDN7/GDWjChunQ/KKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcBZ2CU3rmMZY7UxS2+y2lcPnsiE6PtgEjxYqinE6Mo=;
 b=EstKWYxrT6O6rG6Jq8TrEJZdiJcuJ5FoKgP99hLJF+690juUyXQnJhdJo+KDJPZM5vI7BljVD7we06u1nsHDZojCnLU2U9A4t8gOkp0Si1wp1H64cq9QHoIlj07tYwcNyfHaIPueVUPK6Gk+5LGkMBtCEog6F6aXkygJ8tG4PJZ8Br9C8kUadwMn5FTHsIIU4S8iM6qB8/y2j66ayCfIcRkls8rVs8lMr3cjipHIL7GEGhYW2l48fePrxo+bDRsQvPQEcSxXb9GO8xtfBaK0DQhsRsG44ojEINcGocLDwgW/JVzdFURTunWCb1GGRnXBqxsogBtaUMX6wNEZEXvEIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcBZ2CU3rmMZY7UxS2+y2lcPnsiE6PtgEjxYqinE6Mo=;
 b=yiPyY+kaC2M3/JtNJaolzP349dVsBcw6bnBu3B3paKIyKZBSBs2KcRKikOeuXekkaRjoAP8huOY6ONRGfkTQT3uv/sSX7MED0sHZb3jGZ+RR0K1bscnzz0ogjmvPMRXYgtqeFB0a5zZvHrbG+71FpoO59lfITDUAgUBt4lN+DJg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB8520.namprd12.prod.outlook.com (2603:10b6:208:44d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 07:35:05 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 07:35:05 +0000
Message-ID: <bb1a2e00-aafe-4b2c-8c7c-93801afa3c89@amd.com>
Date: Mon, 18 Aug 2025 09:35:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: zynqmp: Add support for kd240 board
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
References: <cover.1752837842.git.michal.simek@amd.com>
 <05ff505c6b6517e3aba983a21454c568c5e86389.1752837842.git.michal.simek@amd.com>
 <CAL_Jsq+=mnYipAN2q8gdcDF2pK7e8NTOazgq9V+rZSAs9O4PEg@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAL_Jsq+=mnYipAN2q8gdcDF2pK7e8NTOazgq9V+rZSAs9O4PEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::27) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: 78aff0bb-f28c-40f3-97f1-08ddde29bfc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFVYVFIwNi9UT3NnUUxpdkEySE9wazVDYlFBNzNoQ2dzVmpGQjh6RTc4RldZ?=
 =?utf-8?B?bUYwS0c2QzVSK2pMdWo4VTlhcTNlaC9ObnlpbmYyd0x5aVAzUU8rak5iQnN0?=
 =?utf-8?B?Yjh6WjF6MHh4UCtQdEw4cWs5ZC9NbTMxclBYODNNL28rNnJjMUV1L2dDNkdy?=
 =?utf-8?B?VHlOemVpeXNkSDdxTE93eFBITFNyMWxIYi8wOW5yVGxWVXl1ZFJVUVpRZGdz?=
 =?utf-8?B?VXQvTTFOSnNUeHZqWmJ0SU5VYlEvZW1ObTFyZjQ5ZkdrRmFseUtVUG5PbXRW?=
 =?utf-8?B?R1FuOGp5NjF1Wm9pYndGSEc4bVFlRmNpT3RzblJobUo5VSt4Z0ppRldQSk82?=
 =?utf-8?B?RGppSldYTHpDWVRnMGJBQ0ZZWFZkUlpzaXBxZk9xUkR6dHFiMkJYa3FIVjdQ?=
 =?utf-8?B?cGFQdzZPMG8zUWRwNTJpSjlueUM3blAzbEtLeTByWU9EUk1hc05weTIveTl1?=
 =?utf-8?B?eEl3U3BDd1lSeDR4Mm5EWGV4RUpkTUdRc0gvRDdPQ0habE9lWEZTdm9hYlZz?=
 =?utf-8?B?eXo1MTVtQ3hWVWR0TlRzWWpnTjEyUlRDVDhjcHNVRHN2SEpzLzh0aTJEeUxO?=
 =?utf-8?B?YTQyR092b0o5SG5BR2FSdWhJcjNMTXNoUW92S21DQXZVRmEyWXhqN2tjYlBO?=
 =?utf-8?B?SDIwZFd1dUZRNWk0L2c5R2crek1Sd2ltUkE3eEs2L21JUFptNk9rbndwaEUx?=
 =?utf-8?B?SzZhTnh1Y3BKRlBBT3ZQT3o0UXY4bEQyN0JacGpjT2YzakNoQytUTFprb3Jr?=
 =?utf-8?B?R3pybXRzRXkxVHB0Z2VOQUhSZkJ2Q04vMDY4WHVOT1BPL2tGL3huUm4ydGpa?=
 =?utf-8?B?TFg4RFVackE4UnhIaE5zZk80QjFLZ082RTJBdklOeEFxbjhPUmZuQWpHMU96?=
 =?utf-8?B?aWluZjZzWGxwVWhrWmZwQW4rMnlGN3VjM2FVbjFiVnF3UDZ2d1AxYzBoakFC?=
 =?utf-8?B?U0lzbkNmS1dNYVB0TXNLYUZkcFo2NHZlUzRRcHJPRzN2RUYvaTk4NTJOQjI5?=
 =?utf-8?B?elIxVjEzL2ZYdlRhN3RHZnlYQ3pnTDJSLzArYVc0a0Jka0tSd2xmU2g5YVVF?=
 =?utf-8?B?OEJtc1hJcjljRUwwUUlBQ2VyaG4zWkdJcThMWDZrV3haWW1GZ0VUYnFodG1M?=
 =?utf-8?B?K3k5TWJWemE2K3AyQUllL0lFSDVBMWQzVGhVVklUZHY4c054ZkdFSDJVdXRH?=
 =?utf-8?B?cUl5b1R6OFR2dVBMZHFTVFZFVnZHcTFxMER4L3lwTlFwdStoMkN4TTViV3po?=
 =?utf-8?B?N0pUSEpMb3JWMUdLU3dpb2dKcjRUWGIwRFNTV0FDVEpoVmJiTlFxb3VMQTBz?=
 =?utf-8?B?UUhhNDY3c3NMTEhVODR4Z2FudXZNMnBXYWEwa0QwQ1FSSGloQ0tZKzBOajRt?=
 =?utf-8?B?bWpteFE3bWpobEVQUW1QOTR6enZSb2tycVduOXBTY0x0bzBHRlRidGxTQk1r?=
 =?utf-8?B?Q1ZMZnJ1R1RnVnU4dUlBaDJlaGdNcTFzclJodkVCeHUyZ0J1UVhlTi9Edkla?=
 =?utf-8?B?TllUamFrcjhxYjQ5OHZ0aHNtY09TcUh1eURVd2FGUzhVK09SMlg2bjdXazdC?=
 =?utf-8?B?N0pWbUhnL3lYcEsxOFVkbUxmMVZXa0RzRGZsTW1OQnhRNEllRE0vNWZxaGVz?=
 =?utf-8?B?VFp6Uk1TMDA2bGRQWmZmUGI3RFJuNWxXd3NhU2s2aXdzSjZwUEx0SG9xOGxI?=
 =?utf-8?B?UDMrQ0pIbHFXNjR1U3AvMXcwME9hZ0pjbHcxaDBlejlkMklUS1Z2ZTVlTWpi?=
 =?utf-8?B?ZWFlQzcwbnN0Y2NlMXZQaDZoaG5vQVJ4NVZYcWhuS3JWTGdiNmtUOXJidXBp?=
 =?utf-8?B?eENscHFFOEpoWE5rTmE4MzRFYU1LUW9YNmVvdUtSYm00RjZNQXI4TGtSOU10?=
 =?utf-8?B?RXNFU1ZxRm01NlRhcjNaeUJuMWJnVGJIWGlSUWdSY0JYMUZvclFGUW1YeStK?=
 =?utf-8?Q?5Q9CAjBr3OM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejBQYlVaMW9jTVBkRG5TeElpT25aT1BmVFY0YzdqcVhkOVkwbmVERmtJV2hF?=
 =?utf-8?B?V0NTenVnVlAzdGNEUjNEWHpla0NIQVBVL2lZQVEwVkV4cFNNa3lzS1QySnNa?=
 =?utf-8?B?ZzBOMDJxN0JhKzY0MDFXTnNXUWlnSzllVUh6bmdLdFJlMyt3TDN6YUlmVHVi?=
 =?utf-8?B?YWlJRnNvRjJ0V0FpN29IWVQ0OHBMMWlra2Q4dElXYk1EV3BBMVJkUitkRlhS?=
 =?utf-8?B?c2ErNjkwcGNXTnRBejJGL0F0TjNEbHlQMGNadnl3aWpwVU5VTEd5alNWYkxx?=
 =?utf-8?B?allkdW8vajNPYThNVVhveWlCTHhVUjJDMHdCT1ZaZTZxVVVqTkNDN3ZTUW1V?=
 =?utf-8?B?Mm9uanB3YWo2ZTgwMVNzbkQ5Qit3aTFXUjZkd21mRVhYcmp4dTBhVWRuY2Rx?=
 =?utf-8?B?Q2N2dDZ3aTl6WXZiZEpqSHM2MDV1U2hwUGIza3JIK2FaeFR6NUJzUSttVFNY?=
 =?utf-8?B?bndjVzI0cWxlNDNmT2NaQWZ0TDV2aUk3U0tWQkdIeE9lVDRoaHZQYzFCTTV5?=
 =?utf-8?B?UExkenhtU05QaVlnYkoyZTE5RnkwR00zN1B4c0ZkSDlkVHhUVUt5Nk00RVNC?=
 =?utf-8?B?WFIwMEVCWS96Z0pKRUxqbDlNRG1lTDVkcmtNMkhIcnBGYjl5U1dWZ2ZMeDFC?=
 =?utf-8?B?czY3cTVLeGRMamgzS2ZQc3VWRW5RS2pOekNUUGxLWXZtZnFzYWZpUWExSlRX?=
 =?utf-8?B?V2tsdjR3Zk5BbTFjUVJ2d1UvVC9RdXBxK3NIL21oZnVSbnppU0UraThlMWZx?=
 =?utf-8?B?YzhNM2EwTmxaN0xtNW5jSlRVaWxTMUVwWVE1UFBsZGxFTzFZU1BKUktPWkND?=
 =?utf-8?B?MmV6TExvTmsxbyszSVZZdVdpMUhKVlBoSFJ3eURDVkxPemR6RjRmMElmbkJT?=
 =?utf-8?B?NWtuN0pUbWJobTI0alZrVzhTZUgwdzhJNFZ5OXhvVitMWUxTM2RCbFlORVRw?=
 =?utf-8?B?Vm9XRER6UDBrYXVEbTdobm9wTTJQSGtDbWJLV045M093Qnh1Z3BBRzZ6ZEdu?=
 =?utf-8?B?emNUcjRNRFF4TUFhQXZxVGVvN2ppdkJ6Zng5OFBIMXBLZmd6SkVhWCtJeXFj?=
 =?utf-8?B?NWRsdlRRc0FzZHlqNXd6Nk82NFhiZnRQOFJ2MWFyUzMyTU5IbjdwL1IwKzdl?=
 =?utf-8?B?ZTdablBsNGZFZS9HNmFsc0czK0plT2RVekJRV0I5R2pUY3FlaVJpRVQ4V294?=
 =?utf-8?B?Unp3czBwUUpoK1FMaWJmdm1mT1U5Yy9aa0VvMElhZCtwcGtOd3ZkTDZBOFAv?=
 =?utf-8?B?M1dOanFmcmZiSWxUZFZ4UUg4enAxeFhBcUN2dUNWMFJPYTJiSmNyTnVpVjl5?=
 =?utf-8?B?aXVhVDJ5b3o2eitRUmtaUkx5NFNrS05TR1lLSjBoZkIwSnBLT2hSQW9tMHJ1?=
 =?utf-8?B?ZmlHb3hoYS9qNXF6WVBkY2lmd2VaVFppOWNGeTh0OFlHRDFWWXZTOFpJV2F5?=
 =?utf-8?B?elFXNG45Z1RFT1lMNXZ0QWhHTDJHVXRWd24rYjZLL0FrMUsyRklOSTM3d2p5?=
 =?utf-8?B?T3ZJR2VNNWw4QlFUZE81bG5NdTU4WGtwRTJKU1hRKzRXbml6VGFlNS9SejJP?=
 =?utf-8?B?TzVpQTU4RUlZOHhST01Xck5iWk9WbCtPN2RScjVpNWRnekRSaFFWend2QnpP?=
 =?utf-8?B?dDBrcGlMRDVPVmNtTFQ5YnRIOXBOMUEwZGVpaThpMTZVL2hVUExmclhsaDdq?=
 =?utf-8?B?Q3RMY1ljYzBQc0QralZGcEpHa3QwWVYvOEdWR2VCcEpadmgvQzB2aVFtU0dQ?=
 =?utf-8?B?YjUvMTlmQnBMUEE3NHJsS0x5ZDVIWlpHRE5kSG5UVS9MZzF0UmJ4TUdBVGJ3?=
 =?utf-8?B?cXJLckFqRS9sREZSM3cxRGFnelFPMXZDdjNUS21SWHd3Mml5bVk3QUJEby83?=
 =?utf-8?B?ZHRmekM3MktEMXRGYnpwU0RrVTlZclJpY1ltaDlhRi9WNlFPYXpGTEJKdFRj?=
 =?utf-8?B?MFlRSFM3SlR5SkNmWTVxOWpZZzVPMUpHR1hLNnBKNmpmNkkxTlRydzd1ZVNj?=
 =?utf-8?B?eVI0blVRbklLRGJjV1dYQzVVNm1uVS9hR2txZ0lQTmJ3bEhibXZmdGpNRmtF?=
 =?utf-8?B?bGgzTG5DZVVmekxENk9Yd2Y4RWk4VHRXRlA3bldKeHpuMUp5Rks4VW9YaEky?=
 =?utf-8?Q?JRpkVr9CWYNCKrZDLKr9mQoCx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78aff0bb-f28c-40f3-97f1-08ddde29bfc9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 07:35:05.1663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94uMyZz4hgCPtwtLz8HQ2M5OCVgzkK6PKj/vs23wIN3ghO9vTNKbpwNSSglT6icc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8520



On 8/12/25 16:24, Rob Herring wrote:
> On Fri, Jul 18, 2025 at 6:24 AM Michal Simek <michal.simek@amd.com> wrote:
>>
>> The kit is using k24 SOM by default and it is used for motor control and
>> DSP applications.
>>
>> K24 SOM is also possible to used with kv260 and kr260 CC which are also
>> wired in Makefile.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>> https://www.amd.com/en/products/system-on-modules/kria/k24/k24i-industrial.html
>> https://www.amd.com/en/products/system-on-modules/kria/k24/kd240-drives-starter-kit.html
>>
>> ---
>>   arch/arm64/boot/dts/xilinx/Makefile           |  15 +
>>   .../boot/dts/xilinx/zynqmp-sck-kd-g-revA.dtso | 390 ++++++++++++++++++
>>   .../boot/dts/xilinx/zynqmp-sm-k24-revA.dts    |  23 ++
>>   .../boot/dts/xilinx/zynqmp-smk-k24-revA.dts   |  21 +
>>   4 files changed, 449 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kd-g-revA.dtso
>>   create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sm-k24-revA.dts
>>   create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-smk-k24-revA.dts
>>
>> diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
>> index 5e84e3c725e2..70fac0b276df 100644
>> --- a/arch/arm64/boot/dts/xilinx/Makefile
>> +++ b/arch/arm64/boot/dts/xilinx/Makefile
>> @@ -39,4 +39,19 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k26-revA-sck-kr-g-revA.dtb
>>   zynqmp-smk-k26-revA-sck-kr-g-revB-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kr-g-revB.dtbo
>>   dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k26-revA-sck-kr-g-revB.dtb
>>
>> +zynqmp-sm-k24-revA-sck-kd-g-revA-dtbs := zynqmp-sm-k24-revA.dtb zynqmp-sck-kd-g-revA.dtbo
>> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k24-revA-sck-kd-g-revA.dtb
>> +zynqmp-smk-k24-revA-sck-kd-g-revA-dtbs := zynqmp-smk-k24-revA.dtb zynqmp-sck-kd-g-revA.dtbo
>> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k24-revA-sck-kd-g-revA.dtb
>> +
>> +zynqmp-sm-k24-revA-sck-kv-g-revB-dtbs := zynqmp-sm-k24-revA.dtb zynqmp-sck-kv-g-revB.dtbo
>> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k24-revA-sck-kv-g-revB.dtb
>> +zynqmp-smk-k24-revA-sck-kv-g-revB-dtbs := zynqmp-smk-k24-revA.dtb zynqmp-sck-kv-g-revB.dtbo
>> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k24-revA-sck-kv-g-revB.dtb
>> +
>> +zynqmp-sm-k24-revA-sck-kr-g-revB-dtbs := zynqmp-sm-k24-revA.dtb zynqmp-sck-kr-g-revB.dtbo
>> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k24-revA-sck-kr-g-revB.dtb
>> +zynqmp-smk-k24-revA-sck-kr-g-revB-dtbs := zynqmp-smk-k24-revA.dtb zynqmp-sck-kr-g-revB.dtbo
>> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k24-revA-sck-kr-g-revB.dtb
>> +
>>   dtb-$(CONFIG_ARCH_ZYNQMP) += versal-net-vn-x-b2197-01-revA.dtb
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kd-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kd-g-revA.dtso
>> new file mode 100644
>> index 000000000000..02be5e1e8686
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kd-g-revA.dtso
>> @@ -0,0 +1,390 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * dts file for KD240 revA Carrier Card
>> + *
>> + * Copyright (C) 2021 - 2022, Xilinx, Inc.
>> + * Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
>> + *
>> + * Michal Simek <michal.simek@amd.com>
>> + */
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/phy/phy.h>
>> +#include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
>> +
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +&{/} {
>> +       compatible = "xlnx,zynqmp-sk-kd240-rev1",
>> +                    "xlnx,zynqmp-sk-kd240-revB",
>> +                    "xlnx,zynqmp-sk-kd240-revA",
>> +                    "xlnx,zynqmp-sk-kd240", "xlnx,zynqmp";
>> +       model = "ZynqMP KD240 revA/B/1";
>> +
>> +       aliases {
>> +               ethernet0 = "/axi/ethernet@ff0c0000"; /* &gem1 */
>> +       };
>> +
>> +       ina260-u3 {
>> +               compatible = "iio-hwmon";
>> +               io-channels = <&u3 0>, <&u3 1>, <&u3 2>;
>> +       };
>> +
>> +       clk_26: clock2 { /* u17 - USB */
>> +               compatible = "fixed-clock";
>> +               #clock-cells = <0>;
>> +               clock-frequency = <26000000>;
>> +       };
>> +
>> +       clk_25_0: clock4 { /* u92/u91 - GEM2 */
>> +               compatible = "fixed-clock";
>> +               #clock-cells = <0>;
>> +               clock-frequency = <25000000>;
>> +       };
>> +
>> +       clk_25_1: clock5 { /* u92/u91 - GEM3 */
>> +               compatible = "fixed-clock";
>> +               #clock-cells = <0>;
>> +               clock-frequency = <25000000>;
>> +       };
>> +};
>> +
>> +&can0 {
>> +       status = "okay";
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_can0_default>;
>> +};
>> +
>> +&i2c1 { /* I2C_SCK C26/C27 - MIO from SOM */
>> +       #address-cells = <1>;
>> +       #size-cells = <0>;
>> +       pinctrl-names = "default", "gpio";
>> +       pinctrl-0 = <&pinctrl_i2c1_default>;
>> +       pinctrl-1 = <&pinctrl_i2c1_gpio>;
>> +       scl-gpios = <&gpio 24 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>> +       sda-gpios = <&gpio 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>> +
>> +       u3: ina260@40 { /* u3 */
>> +               compatible = "ti,ina260";
>> +               #io-channel-cells = <1>;
>> +               label = "ina260-u14";
>> +               reg = <0x40>;
>> +       };
>> +
>> +       slg7xl45106: gpio@11 { /* u13 - reset logic */
>> +               compatible = "dlg,slg7xl45106";
>> +               reg = <0x11>;
>> +               label = "resetchip";
> 
> 'label' is not a documented property for this binding. Please drop.
> "dtbs_check" reports this.
> 

I has been added by

commit fc449cefe69d19d3a56903ca7e0fbc91c48ca3f5
Author:     Michal Simek <michal.simek@amd.com>
AuthorDate: Thu Feb 1 11:24:20 2024 +0100
Commit:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
CommitDate: Mon Feb 5 09:29:20 2024 +0100

     dt-bindings: gpio: pca9570: Add label property

     Add a label property to allow a custom name to be used for identifying
     a device on the board. This is useful when multiple devices are present on
     the same board. Similar change was done by commit ffae65fb1ae4
     ("dt-bindings: spi: spi-cadence: Add label property") or by commit
     a53faa6bfa3b ("dt-bindings: hwmon: ina2xx: Add label property").

     Signed-off-by: Michal Simek <michal.simek@amd.com>
     Acked-by: Rob Herring <robh@kernel.org>
     Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

If it is not correct it should be fixed. I see the same description in
Documentation/devicetree/bindings/input/gpio-keys.yaml
or
Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml


label:
   description: Descriptive name of the key.


or different
Documentation/devicetree/bindings/input/adc-keys.yaml:41:      label: true


Documentation/devicetree/bindings/arm/vexpress-config.yaml:153:      label:
Documentation/devicetree/bindings/arm/vexpress-config.yaml-154-        maxItems: 1

Please let me know how you want me to fix it.

Thanks,
Michal


