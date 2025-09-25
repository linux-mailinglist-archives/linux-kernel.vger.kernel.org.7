Return-Path: <linux-kernel+bounces-832892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D337DBA0AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440171884405
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC7222B8AB;
	Thu, 25 Sep 2025 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sch.bme.hu header.i=@sch.bme.hu header.b="BQe1Y32p"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020116.outbound.protection.outlook.com [52.101.84.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB9035940;
	Thu, 25 Sep 2025 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818689; cv=fail; b=oP6CKB0EsmxGO2uLMUslD21nkorgwea3/qnyuHQILH8kk+zT/9uMgSG0uH7vmPozjc2qFaLs7lkJ8+o0dR7quLIoXW/VmS76/hViTp6ZStO/226+QT5N0HQ6FHQ0C/bcmIwbQb/h35NHQ3dXYWKXHcmO8JBkYcBKRjPNuByYGjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818689; c=relaxed/simple;
	bh=k1FS2AWwOxRlfZzA/FtFxK+4aEDKYfZLy+HL3T+W9eA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DEdEBT0PkKLJeGK97lykNKbXa9WPFgzKaQ3oQDWuefcKr8bHtgvqwFh14G+QXzenPpxYJbAmdrekKEtAhagSpPF4/PV2UMcTecez8MEX0+t3By02NPSzPS7TSsGCxDCcGn6Dn0BZnH258AaEFAKBtAfYc2eFmA7F5H8XsKexOYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sch.bme.hu; spf=pass smtp.mailfrom=sch.bme.hu; dkim=pass (1024-bit key) header.d=sch.bme.hu header.i=@sch.bme.hu header.b=BQe1Y32p; arc=fail smtp.client-ip=52.101.84.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sch.bme.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sch.bme.hu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EeEbsma0R7ARahjZf4m5Xmq9DyIPMq380jtAaeEsYIPadk2ISfnxITjq5JVFngG/mbd4KzUASqxgoPz7eypLnPHZiiND0mHs0hyZgkNogC1SIHcMn9elW8FlM3RGLOFlUvQisA3hxm4mTXAZZtU1ZXTBwzVwJdFTVerss0vJffl/bk2rTF0FD54RMEJTvrGhcqNCsNlWMfTLQCJgPzYkL5hlCyiWwoN/QZ+MZxEvRMEjdccKVJgq3SCSb5h6Yg11Vb2+xrvzfialV9ZhNU+JzBxUDrKjJmEfBc6wzzvuM8CiGxJlRbj478KwCnZiqB3PfYWtZ6ZNWkmD1AUymz/NqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvmeVwAxaysDayyOLNSICok/LFnmKXQ1/a1mOuO8Uec=;
 b=ApezayDq+pHlpayAU7QzL78bRWavykUfKZ2REr+6ITHWcqsa/h8SKidor5Q9fCoC1FuoElDD5iad776Z9HkrGiM0boPMqdv7J8kBHM0318WgI/xJka0VL+lc2Slm8Lybv7+O14CAC9OghfGEztjmLeghxUHgq2QWJYXITZP3DlSZgPolo6wW4h7vMxzhDXQdxCHWa2uElvvUrLG+otIpT4kcuBK5iam1v5wb02nIMrJf/znatpvlQ7w8P3sNJwusoBxWU/DvgWSQx/gFICyAry+ZP0S5+GMV4N2F9NDTKt0kQ+PqDcDHlfB8mZcGn/YLz4PNfOiZvE/FOyx/e54Oaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sch.bme.hu; dmarc=pass action=none header.from=sch.bme.hu;
 dkim=pass header.d=sch.bme.hu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sch.bme.hu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvmeVwAxaysDayyOLNSICok/LFnmKXQ1/a1mOuO8Uec=;
 b=BQe1Y32pzpTL5iAQ+A7KoMfCB7r/QWUTgrT7dkHj2WJdrN/5vNLUvQkhV0W+ASLPokpmt6I0N3+dWxf9chdv0obAF3TpfSdejFn5Z2utChSumFCK0D58LXbR66+Q/tejVHZXKHqFNj5IxZrFsmj7FYo72XG/j12Dc3RtVabiK7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sch.bme.hu;
Received: from VI1PR04MB3984.eurprd04.prod.outlook.com (2603:10a6:803:4e::28)
 by VE1PR04MB7456.eurprd04.prod.outlook.com (2603:10a6:800:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 16:44:41 +0000
Received: from VI1PR04MB3984.eurprd04.prod.outlook.com
 ([fe80::e8a0:97a2:eb7b:afae]) by VI1PR04MB3984.eurprd04.prod.outlook.com
 ([fe80::e8a0:97a2:eb7b:afae%7]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 16:44:40 +0000
Message-ID: <78cae034-77a3-43bc-87c1-18344d5ba8c8@sch.bme.hu>
Date: Thu, 25 Sep 2025 18:44:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] ARM: dts: imx53-usbarmory: Replace license text
 comment with SPDX identifier
To: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrej Rosano <andrej.rosano@reversec.com>,
 Andrej Rosano <andrej@inversepath.com>
References: <20250814-imx-misc-dts-lic-v2-0-faff7db49a5f@prolan.hu>
 <20250814-imx-misc-dts-lic-v2-2-faff7db49a5f@prolan.hu>
 <aMKEF4wAeET3Ntus@stjenka.localdomain>
Content-Language: en-US
From: =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?= <bence98@sch.bme.hu>
In-Reply-To: <aMKEF4wAeET3Ntus@stjenka.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::20) To VI1PR04MB3984.eurprd04.prod.outlook.com
 (2603:10a6:803:4e::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB3984:EE_|VE1PR04MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: c50d9052-0d5a-489a-4908-08ddfc52d212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|41320700013|1800799024|7416014|376014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R085bkdmOTVRaVNyc1dSOWQvTUl0S1pwUXNhN2pEc2N1YzBsbkdZeFV3WVgv?=
 =?utf-8?B?OU9DTmxhdkpRZ24wTnEzditWaGdyNmZKVktBd1dkSlRqK0YxNEhFRUZqMWJY?=
 =?utf-8?B?UlpuWWtMdlVuZTRsZmR2VEJteG5tSkllRmtGR3RJQUpiRzlvcW9LT1NQbysr?=
 =?utf-8?B?UGFQTUZ4cTVESDg1SzJzYUJnREEyZ09CZjVLZ0doL1FIS1JyUjI0cC95TGhU?=
 =?utf-8?B?MGxlUFFaVWU1TmlRUWYrbkNINHdIcWJZdEV5VFAxUitjTEE0UllCbldnYWRn?=
 =?utf-8?B?ay9VVlVVMEJoeS8vR3ZZK05GUjMxSVZ2MFV2cjlWSVQrVW1JaVIxZ1NuMUhT?=
 =?utf-8?B?RWprK1I4aWtUZG9tWDZ0eHJCbUxDQjh3STlDdWdPOFZKeGV6Sy9lVFpkOHZS?=
 =?utf-8?B?dHJuVW5UY3BOeXc2ZGRHd1VjYS9JVURpMmZuVUE4VkplU3BOdGFZOEtUZ1lr?=
 =?utf-8?B?NDkrYzlOTXZIbCtsSjNHRFZDU01MYVlST1ZUa0VNNkFpWEk2OVg4elYvaVdw?=
 =?utf-8?B?cVluUjhrYmVFM1NMYmp1RWV0dDdJbytWRnIxTEpmSkZKZFY1aVhYcVFIdUcy?=
 =?utf-8?B?RGFiWG4zcXp6a1VJQ29lc09IRlQrK0JwWCsvZ3pNejRWaUw4VG1PM0ZjRnNy?=
 =?utf-8?B?NFhPV05ueVRwTUkxYXdEWmcyTFBEK2RVZTFGSjh4UC8wczUybkhSSllEZGFP?=
 =?utf-8?B?YlRIT2d6Sk5neGI2bkVJUDVCME0ydlAybWE0U2xqblJvL1FJRGVFNTlTK0ZY?=
 =?utf-8?B?RERxREtaWUV5Ny8vM2I0NStjRG1rR1JMTmNoL3FnTzNkVXZqNTlVRlBBSHVJ?=
 =?utf-8?B?QmJsOGRmSit3V05LbmhGMEZaVVU2aWdCcElkOWE1Zkg1ekJ4RHg1cVpnay9W?=
 =?utf-8?B?U1l3SHpIc21UR0RNUXNoRDJzL3pscjJnckgwaFhESjRSRGhnTmRNY05OdE5x?=
 =?utf-8?B?aWVFN0JUQTdXbGhLZG5JOTRXaGdKdmVzNU5tV3NQSUZCYXVNVnBDUVhBNDhO?=
 =?utf-8?B?T1BOWm5XdzdrREgwa2pxb3NWRU9yajh2YnVVSmZ3eVVKaU1qdXVPNkUvdGRJ?=
 =?utf-8?B?cStiTEZ1QWp2V2FERFU3Rjk2NWduMEM1VnRySmFiNENRdHpVZlhtRi8vem1x?=
 =?utf-8?B?WmtadE9qaTVoSXRNZCtDT084Nm1jeG93NkZrK3EzRzE1QjRENWpGZnRpQ3hj?=
 =?utf-8?B?ME5VMGFhMjNrVFpXdkNZazZici9FdHphb1NwczdoUFFWWEJubytGbXFVSkZS?=
 =?utf-8?B?RUVwRWJaN2N5SWZ5RHZ4cUlZMSs1UVRIdmpmM1FPQUxGRUpDYjZmenUxVk1Y?=
 =?utf-8?B?c1FkaGNFUG1KZmJ6NUdkVEtMKzlMUitqWjFSckpMME41MEZxSE1Jbk4yTitO?=
 =?utf-8?B?alJ6a3drTXJ5U28yQmV3SEFKWHFYQWhiYnhuREF3Q3dkdllpQTA2SmNVRy8w?=
 =?utf-8?B?MkdEM0Z5KzZPcWVmZ1NudWU2dG1kR2NON0d1N1JVOTRGZGJWZU42N2Zhd0RF?=
 =?utf-8?B?ZzJzZkV5bFVyc2hPdTlDTFdUZ25jVC9XN3BoemxBQ1FWMDk5Zm5yejV6NGxr?=
 =?utf-8?B?NWIrdU5ua0hLNWpacTMrb0sxN3hQWElySXJNUDN2b05wU3JrbmNKQkdUR3V0?=
 =?utf-8?B?N3BJVWxjTU01d3Q5TDQrQ0Fham8yZWY3YjZoRURjWnNuaEtBQXpqaGg1dXRo?=
 =?utf-8?B?eEFqNXBwQS9kYjRiOFNFblRPVjVHTHZ0SEx4L0JOZ2tudkpkRU9NQms5clcz?=
 =?utf-8?B?dys0bGlGRFpsTDJOdjAzTUNrdFlTQmE3aFhyLy9JcU9KM0FON3dmSzZsbDBW?=
 =?utf-8?Q?6cKZLXVqU6Ssz0zUvXus0aKtlDul9Xp8J+FAA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3984.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(1800799024)(7416014)(376014)(19092799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K08rQ1JUbHg3eFkxT2NQQlA0RGk0MWxBQ0kwM1QwYU5leFd1Mkg1ZXRPemtB?=
 =?utf-8?B?Q0pxVzZiZmhVQUoyclR4M0MzNS9iZk5wcTJtNFp6cU1GMFdtQnE2SVNjdmhs?=
 =?utf-8?B?MUxBcVNaMFRSRmlhMDhhUU9abU5YQ0lTL204dVFNc1BEN1llbmhFVVpUeVJk?=
 =?utf-8?B?VVRlbjBtZ3FZS2pzYkJtWkJhLzdjYW5TTWJpRE9ObkdoUXQ4Y2Fad0xtUTh0?=
 =?utf-8?B?aWFiZEJGNld6ak5LaWVEaUdrbTFkcFpiR2M3WUt6RVhPWnpkdmtWS1JhRm9P?=
 =?utf-8?B?cjYxbjdrWHZHL0NZOTdBbDh2T0JWYjByNnY4NWVvazZCTjZwcXhKdmo2WXpF?=
 =?utf-8?B?Y3QxVGJuejErcU1uZGlLQkFFY3A5YnRFMGtkYWt3dzVPWjdObmY0YmpaeW1E?=
 =?utf-8?B?WUI1VURRa3hxTExTSGliQmZoRi9Lb2Vwb3p4ckduQXAyL0J4Q2VHak9EMlJP?=
 =?utf-8?B?K0dGUVkwdWxUYmJtdGRzNFJ5V3NvS3dIT3NUbFZsZmlTTElEZUk0N0dYSmky?=
 =?utf-8?B?UW5rVzJtUjZWbXR0b0JFVDlUWnJpNVk4dlVybVNvUHg4a2x3bkhGYUo2V2Zn?=
 =?utf-8?B?S1F2bUU5OXB5UlNwTXEvQnpzQ0ZjMzAyNzNYYy9UbmdHclM4MHMvSks4ZzBS?=
 =?utf-8?B?SXh3c2RvVVR5d0p2aXdjN0JBVnk5QUZXRnF0bjhZeHNkMFdiMW5DQXNsWWJD?=
 =?utf-8?B?cDBTNzVxK1FUdFVtYlpOOFhOd0JhVDVoQTBQdTlVSlFCc2J3UVA1Z3hDNmww?=
 =?utf-8?B?TURXeCtMb0xRd2E3NGFtV1VDbWoxaEF6d0FzQlUzQStkOElRQ2JDaGhidlNs?=
 =?utf-8?B?UnNBdGMzamxJRlJrenBuQWdobTZ3dXkvWVJyVTVLWnNYS1o4a3NlL2dtTHJK?=
 =?utf-8?B?RUlJMlNCWUtyT2lzcjB3eXNQT0RyQVE1dExncjB2L2JEeXNGUXMwZkxjK0VE?=
 =?utf-8?B?QkRtdm5RY1V5U2FhcTVSWEFuRk9tT2txOUlWNkkvcldBZFRaRTFUTzc0cmRN?=
 =?utf-8?B?a0xtcXNoQ1NOczhHVm1CVnAxVWd0ckZ2Ty9ubU1CblViMDByT1FXaUwwVnNW?=
 =?utf-8?B?Z0ErQlNUWnpWQ2ZlMVhMN0RJVUUzTjkrMjdWMU5jeHY0K2wwYTRKZzkwM2p4?=
 =?utf-8?B?S1BIQWxQWUh0ZlVkMkhjV1B5OGtGcTh5QmJ0Z200WVhtRTFLQXVPSzJ2VUEy?=
 =?utf-8?B?dExxRC8vcUlONTgxOHZySFQzUXh0czVpTHpGeHhPMG5wWXhrVFVjWVR0K2NO?=
 =?utf-8?B?V2dvcmxtK1VseHVHMkhRSHJNNzdMWkYrUkN4dHBBd2JCYm5jMHdCTjB2R3pI?=
 =?utf-8?B?KzZqMUpLVW1iRHZNNnozbjRaa1g1ay92RHlONUdqWmRqdjhyMGlFelo2WGdh?=
 =?utf-8?B?bStBcU1qSHpJRGY5c2RPRG5ZMEgrRG8zOFRBZTNlRGErSWtmeTlQNE9DQVNY?=
 =?utf-8?B?RGhEcVBnRXJneFVnQUpRSnAxMjBiZmFPYmI3cTR4N2hUd3BCWTY1M1o0VEtN?=
 =?utf-8?B?L0U5VHV2S0xOUVRUOVU5NlNCZDgxSk9VYzVVKy82Qk1BQXNxZnBLYlJwQ25n?=
 =?utf-8?B?WTBzaEJjOWRVQlNhdEp1RTBkSS9BbW5pdEtVME1xeS9aemE2c1BOMmtuSFFX?=
 =?utf-8?B?b3JzeEZvTFhKbnljLzZEaEh2MUNYTi83enFpM0crNWl4QXJvOHFWWkVFdVVG?=
 =?utf-8?B?Q2N5ZzNtb1JHSS9KUStyU1dZcU1LVEdsN3YvV1dSZ3V0dGVKS0xwODZ3ejBK?=
 =?utf-8?B?ejRTNTd5T3dWTkdnS2F6MHVYNERlV1JEdGNEM2ZFM0NPSWFLTUYvdmUrazNl?=
 =?utf-8?B?ZGJoNko2N001VTNVVDg0L1dSUkVTUkhzYXIvMWlpand3ejdvSDJiZ2lCSExu?=
 =?utf-8?B?WVQ0Ly9JcGlXMEIwSTRGM2pYbWRqUm1oWEVEbHg4L2QvQ0wyMDNDRVJSOXFW?=
 =?utf-8?B?SkErSjFUWk9nZVBQQk1UTEkzY283b244WHdZbTVEcjU5MlBmc1pEbGpCV01r?=
 =?utf-8?B?RWlRbG10U0xsZ0lkZ0dpYmhUVXcwOThZWnM3dUI3Ti95Zkc5MjlhYUlXRVl3?=
 =?utf-8?B?VG5UNVVkOUJNOUpKTElONmZnUTBIc0M1REFFd05aN09Hc0F4Q2g5cU5DQjJO?=
 =?utf-8?Q?/GruJko87YpZged1gNRWPUWwJ?=
X-OriginatorOrg: sch.bme.hu
X-MS-Exchange-CrossTenant-Network-Message-Id: c50d9052-0d5a-489a-4908-08ddfc52d212
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3984.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 16:44:40.2676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 79f0ae63-ef51-49f5-9f51-78a3346e1507
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Imq4/sE36U74xWijNcDoLCWNqOQVrIOfrYHvW3Nag76XkauJR80lPw2OO0rtyow8AtdZD4ZFQrL4TXgikr+aKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7456

Dear maintainers,

On 2025. 09. 11. 10:11, Andrej Rosano wrote:
> On 2025-08-14 Thu, Bence Csókás wrote:
>> Replace verbatim license text with a `SPDX-License-Identifier`.
>>
>> The comment header mis-attributes this license to be "X11", but the
>> license text does not include the last line "Except as contained in this
>> notice, the name of the X Consortium shall not be used in advertising or
>> otherwise to promote the sale, use or other dealings in this Software
>> without prior written authorization from the X Consortium.". Therefore,
>> this license is actually equivalent to the SPDX "MIT" license (confirmed
>> by text diffing).
>>
>> Cc: Andrej Rosano <andrej@inversepath.com>
>> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
>> ---
>>   arch/arm/boot/dts/nxp/imx/imx53-usbarmory.dts | 39 +--------------------------
>>   1 file changed, 1 insertion(+), 38 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/nxp/imx/imx53-usbarmory.dts b/arch/arm/boot/dts/nxp/imx/imx53-usbarmory.dts
>> index acc44010d510695b28dc8e6599ba006856a89efb..3ad9db4b144254f5400ce894f99fb038e51f64f4 100644
>> --- a/arch/arm/boot/dts/nxp/imx/imx53-usbarmory.dts
>> +++ b/arch/arm/boot/dts/nxp/imx/imx53-usbarmory.dts
>> @@ -1,47 +1,10 @@
>> +// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
>>   /*
>>    * USB armory MkI device tree file
>>    * https://inversepath.com/usbarmory
>>    *
>>    * Copyright (C) 2015, Inverse Path
>>    * Andrej Rosano <andrej@inversepath.com>
>> - *
>> - * This file is dual-licensed: you can use it either under the terms
>> - * of the GPL or the X11 license, at your option. Note that this dual
>> - * licensing only applies to this file, and not this project as a
>> - * whole.
>> - *
>> - *  a) This file is free software; you can redistribute it and/or
>> - *     modify it under the terms of the GNU General Public License as
>> - *     published by the Free Software Foundation; either version 2 of the
>> - *     License, or (at your option) any later version.
>> - *
>> - *     This file is distributed in the hope that it will be useful,
>> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> - *     GNU General Public License for more details.
>> - *
>> - * Or, alternatively,
>> - *
>> - *  b) Permission is hereby granted, free of charge, to any person
>> - *     obtaining a copy of this software and associated documentation
>> - *     files (the "Software"), to deal in the Software without
>> - *     restriction, including without limitation the rights to use,
>> - *     copy, modify, merge, publish, distribute, sublicense, and/or
>> - *     sell copies of the Software, and to permit persons to whom the
>> - *     Software is furnished to do so, subject to the following
>> - *     conditions:
>> - *
>> - *     The above copyright notice and this permission notice shall be
>> - *     included in all copies or substantial portions of the Software.
>> - *
>> - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> - *     OTHER DEALINGS IN THE SOFTWARE.
>>    */
>>   
>>   /dts-v1/;
>>
>> -- 
>> 2.43.0
>>
>>
> 
> Acked-by: Andrej Rosano <andrej.rosano@reversec.com>

Would it be possible to partial-apply just this patch? Or should I maybe 
resubmit it alone? The patches in this "series" are not really related 
after all.

I'm trying to pick this up again, now having left Prolan, and it would 
be great if I could grep through linux-next to see which patches did not 
receive an Ack yet.

Bence

