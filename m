Return-Path: <linux-kernel+bounces-882239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A85C29F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 04:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00B2E188D967
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 03:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F43528C871;
	Mon,  3 Nov 2025 03:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VSUBuxf1"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010041.outbound.protection.outlook.com [52.101.84.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897FB288C13
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 03:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762140441; cv=fail; b=PsggoiQY5icmkixXETjqtvPPVlilcjjRrnS7dO7aoHFRknefKpq5mOtB0lrOJPFZrLlN3a1pnalOiaBkSImxyjDaV7A91ZgRPsKy5wz/smwzRD1k5AK9KY0pxDFSmzJlTcOV9HRxHIUjbpUwVj+n6O79Dfhi0XnPBZns1vG6HaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762140441; c=relaxed/simple;
	bh=IAOOPt9cBIsqI2II1T2AgWjCcDLa7fmGXuhkFtzUFeo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sKsMD4OgcRAhTtcqQ6mXgndHS3z08wcauGo2iHvQAgMhWSVr6ZoKfni0g9OLEi+42+F909m+R9yhGewcXmlOa5uQpTAHJ7+J7t7YeWvZL++0ENjQDW54gxGXaB4DO98W9G9foTlWWLtjiBRiXPohmXv8kof0a1xcNii0S6vh8Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VSUBuxf1; arc=fail smtp.client-ip=52.101.84.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxcadBcFIjAwMBNBwHO6MBFYJlQBBpX2jPs1JtcMYOyRHojwiP7Xjk7v+Ck4SBI0EluLQmN9CLHSlrTlYTnyawzqT8X7XoIOPGwxp3ZT2LBUla96mzIb95omx+SmuhS2gqHaiP4KGtlRmbVnWf54VYxQTmQd0ZOoBPluMAnhLWFKR1g/++5ByBioK7CSrP2GGTVcgoHpf1iN8XT+19Dc51B8TiLC0LjkzIt2PtFgl2HUOEgEoKYXHk5u5QzCgwWaf8qXtKZBiTRiW/v4GUtOa25O798zflN+lS+xTfy1QnwlGaHVFZ96QKDHDIH2PHEgDcXjHdSxzue9JC86WRgx5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjCPCPsn4bTdXVIb2836BmEnNAniao154SY4n4Y+B0o=;
 b=w54x+qfVAd5otsyJH7mhVij1BmkeLP+dxtYR2WBKxIbJWh0UAWtNwIodY8mUzOvLqfdngnaKhbIHvVcjddsperEZIfops1M1HIDILSTP1gjxVJ8qggRSnVsS84NX2mZZM2E23gAkReH441zFyB2gB55PsEOGoFLhDP/K20LElY7ueFBS4uVwWZqnKevsWmbxIDavHFlo9RvVpiaM+urUDkUXjoFa1d6K3vWnZIX5MH5LvPcryXpQM7XCDeSI8m2e5f9zd/5nQ+MVrIn7D+3cHWWX3WOrKvMmkOmPMT8S224WMWpYlTJEPJ33afH0CZK2cprKuuOg5w4nr0VEAXkihw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjCPCPsn4bTdXVIb2836BmEnNAniao154SY4n4Y+B0o=;
 b=VSUBuxf1vpCiAWNMN7Bgr1u+zxDY1gfo4mBOxOv+rLrLSbI0sOjCKNG08PusWknkQTjGa/nd0Z3uQWU9t12/1X/YgRPK/Ffip3JM4KRbPMGbOZ0o65ITXBaCMM2SCkDe9dMTYEzxVNmikMh/Dyios9n7ni6aRUkYLV7BJlTUlaTIBdhHFd35E/ol1mqEuIwmTgVhRH6jD8OsRgV3wQCtZ4OaBPoljXTusTFPgf0DOvGMFRTG5rV1tw84mVG8uPT2Ya10n1r2O/WiVDlBDAl+7f7HEuJP2yMlUR0dOb4cF0sSsK+qvfSQiw8TkthG3puN6uq6iGuc4WMWwxJD0wJJ6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DU2PR04MB8744.eurprd04.prod.outlook.com (2603:10a6:10:2e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 03:27:15 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 03:27:15 +0000
From: Joy Zou <joy.zou@nxp.com>
Date: Mon, 03 Nov 2025 11:26:48 +0800
Subject: [PATCH 2/3] regulator: pf9453: remove low power mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-b4-next-pf9453-v1-2-a025d536eee1@nxp.com>
References: <20251103-b4-next-pf9453-v1-0-a025d536eee1@nxp.com>
In-Reply-To: <20251103-b4-next-pf9453-v1-0-a025d536eee1@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
Cc: linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33)
 To AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|DU2PR04MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: a6d61fab-04bb-49ed-7918-08de1a88e25a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUhoRUQyUThnaUVTV0Y0ZmNXR1gxRDBDbGs5VWVRbmM1bnEyZVljU04rYWdz?=
 =?utf-8?B?QlBsYzdZQ2xndU02bTFiT0RhWGI1cDJSNU96QTB1aFVpd2pnMEM1Ti9EWUxU?=
 =?utf-8?B?c2JsMWV2YmdsSVl5aEdOakQxMEUramJ0VFZ5cWp0V1NiTVppSWZsY2lLMUNF?=
 =?utf-8?B?RFlTVE9TVHFvY1VuTjU4NytXQ3JxeUxqTmpKZXZWNEZjNlJ5a0pjQVhRN1hp?=
 =?utf-8?B?ZmdOUlJRMm01M1lMVlVjU3k2VUJjQVpxeExlN1dOZzQrZ1dSZUJFcWNOMVNN?=
 =?utf-8?B?RFJGcTBzZFRGY2w2eWhBMUhIcm1BS0tiK1lHZVlobW51bWtmSE5jdU9KYWZC?=
 =?utf-8?B?azRFVWZOakwzT2JDdG5zUGJ1aU1zaE1GNGZNNGpUQ1UrTmIzVXBmNVhZa2ts?=
 =?utf-8?B?aFhZcXpSYVJpTXBpMGVGbkpuRE5BUUhaYzdBekFqSTVFSGkwSlc1emYwTFlK?=
 =?utf-8?B?VUZRcnpqTW9uN1NyeHVNeGU5MHpRaGxGRjhsTlllQkM4VUkwTHVaUnhJVDJ4?=
 =?utf-8?B?Znd3WjNLNGdoVmlQS3VxQ2gzLzdEZVVDRnQ3YVN5K3dUWEtwS1JoaFRBdGJR?=
 =?utf-8?B?WlBGNTNHQWVzV0ZyK2JFRUh0UFJCU1VvN1pCcXYxSW5pa3cyZlZ1WlVHRnAy?=
 =?utf-8?B?QVlvT005dmNnUHZZaXVDZzJoS3N4TDdaT2Vsc0dYTisrZTJXcHZUYnJWK0Nj?=
 =?utf-8?B?dVhFTWJwbW5zY01rUi9WeFJwUWY5cjdrMm9NbU43OWQ5Qng4dXBhVVZTRjdv?=
 =?utf-8?B?TG1nWEY5cGZOeE1HVGlPUmt0RERYY29LVkhjMUwzcE13UHBsMFFkTHBGY0Fu?=
 =?utf-8?B?VVNvV1JUWEQ3ZUVIVi9ia0hNcnEzclRNRCtUM1h1OGNwT2kyMDNyMWd0U3Zk?=
 =?utf-8?B?WDF2VEhsNE9kWHkxM21TU2ozVWVuRXRSY3JKQ09yNjRtUHVrQ2RYbDIweGlI?=
 =?utf-8?B?YTBXdVlTWnAvUzNaNnV2OHJGTDBKV1g5cUV4UUdHK3lGci9WRDJSUEdFeVow?=
 =?utf-8?B?emUwZzFMVlA5L1FYRDU5MWlVTWxBOVo1NzVFYndZcXRTT0s2OUNIOWdKK3p2?=
 =?utf-8?B?UUlOVmRtM2lkUjJkRitYSlJxWUM0aWlkaUMxSXMvR214NUpMeXhzVmtRMmwv?=
 =?utf-8?B?ZkVJcUJla0hrMVZzL1F2QVFKenVoZlBTSUdvLy9VT3RpaFU2aFlzeTlIQXY2?=
 =?utf-8?B?NDlJNTM4RDRJZDhYMXpvSkdHcWJwZng4R2xMeVhJS01mZWZtSXBmNENlVFpk?=
 =?utf-8?B?WHNDN2JTc1V0NDQ5bzJ4cWVKVW5Gby9Zc3ZxOEFFeUVUbEt3Ylp0akdBRkxu?=
 =?utf-8?B?WFZBaU9kelBlSlF5OFd2TUE5cEI2SWg2VjFINnJESU0rd0VlcXU3eDQ5YnVE?=
 =?utf-8?B?UVN5VkxFTHluU3p3anhuOEdaNWY3N0JncFZGT2F5V1hhSHFUU1ZkaUNWNEFi?=
 =?utf-8?B?d3h5QTJkR3lFVXI5L3c4STh0aytBWkhpc0pNR01iNEdHUzBHWmlTMUhqRFlH?=
 =?utf-8?B?MFFHcE9oTU5aRUFzL0NGVkM3c2pQc1oyaWk2NmdzU09HT2FKUUVPNGJyWlc3?=
 =?utf-8?B?NTQ2bGFtSFdtbVdHTi9HNEY1NzF2aEl6bkFkYnl6NmZYVkc0cUM4cjA4NG4w?=
 =?utf-8?B?UHlVZms4MWIzQjJWZU9jbTRDSVQ5Z3h4NU5Oa3Z3UDlqaHZWeDg3NmxEUnF2?=
 =?utf-8?B?c0J2NVFocyt2STBFM1hNRTFmU0N6TWxSWXRtNk9NRVRFRUowVWh5cC9Bb3o5?=
 =?utf-8?B?bXZzOEI3RVNnQ3hJNHJ6aTJGZ0pSbkZsenR5MHpGcDdUUU5qRVY4dFNmRGZ5?=
 =?utf-8?B?R2dOUE9GZnRNUEl3WTZlMHVZa0tpYW56VGZlM3JCc3ZwVEJYRU5lV1Rma3JO?=
 =?utf-8?B?Lzd2YUJ4aXBRUHFJWmEwM3Nzc1ZwZjd6bVQxYmRGZWVkMFU0SDBhRUllcDRE?=
 =?utf-8?B?L0RYWnVuSXRtWW96V2M1M29FbkNSSkJ6WTBYamNLZm1uOXlUSW9BdHp0ZytE?=
 =?utf-8?B?aXhMbjdaVm5ac0Y5UWVnVklOSHE2NlRrQjQ2T1h6UXVIaFhPbFhXSitFZE5n?=
 =?utf-8?Q?NKTY+U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akxOdSt3NWVPZzRWazVRV3VCRFhIL1UxK3ZPWVlkb1Vjd2pieXo5MEtmYXlB?=
 =?utf-8?B?Uk81d053Vk9ZeXgrR3JNbFhqam50UTR0UnNtKzl5SUtlMzErdEZ5a1cwREdG?=
 =?utf-8?B?d0VtU0FzWXQxZm94UExCaEFMVUYrY25QOXpXdlVpVCtOdG1BVDR6ZE83aFN5?=
 =?utf-8?B?ajQvK1M3bEc0YnI5K3crZDJ2aFErZ3pTbTFBTC9oUGZ2d0VnMXF5ZnQ5cnRa?=
 =?utf-8?B?c1p2cnVuT2RLcjBaVlFPQXpSekxUekwvcFZJOGxOc1hhcGJZS3QxVDhGcWho?=
 =?utf-8?B?Q1Z6VThrTzErMlp0Y0lsSWljZHl3YitRTUlMWEJ4ajhleG44VjJpSVBMVXVa?=
 =?utf-8?B?MEtDeTUrNVZPV3VzRFN3SnJxVm5SMEFFQWFSRGtLZ2NIQ1dyOEE4SUk4c21Q?=
 =?utf-8?B?MjJpa000amd1VUF2NXlXcHh3c2tkbEhRbXVVYWIxS1VVWEFWUmtSYm93QVNQ?=
 =?utf-8?B?VDR4anYzblRFdHJ3UHplckNTeVhHUUJNcFFLbGlBNnNCYS8yVjAyOURLbUJi?=
 =?utf-8?B?NnUrY1I4Z0xCY0pwS2dML0IxcFZ3Qk5HTFF4N0U4WnJGbEhrakg3b2QvNDUx?=
 =?utf-8?B?Wk43RlR5VEJOU2ZTYUJSMmFEdHFxYnpKenBjVElqM2RyUXBqSURSeGM5Nm1M?=
 =?utf-8?B?YVlib1daMTV6aVZOYTUxY2xFZnh3VDErV1k1MURHNCtWWjBIUXZqU1h6Q0Jj?=
 =?utf-8?B?WjMrdHV3V0pDN2s1eE9NMzJGYmtZVm0zN2xsdHhVRUdUenZORkpzSGN1UXVH?=
 =?utf-8?B?TFFBN1oxWTA1YWJuUDZaL3lhcWRNSG9ZR2QvazVhalNoWGVCcEhLeWovR0V1?=
 =?utf-8?B?Ly9pcml3amZxSTI0RHl0YlNCYXRRNVFoZGVBQ0YrMko5ZHAvbjRDVzMvQTY5?=
 =?utf-8?B?dmpyQ0RqdnlFR2xMVGRISStsUHhLU2lnc2wySkduSHd3ZUlPcGg5ZjJob2xu?=
 =?utf-8?B?VHAvUHFTZENsVXYxWFIwOTBoM1hhdzFtU3dhbU9RU0pocmFHWEM5bVpETFcr?=
 =?utf-8?B?N2FMdndFb2lsT1drVjJIcEpvdnZQUCtySVhzbXZpZGZoV3BjUWcrYTM5bzNZ?=
 =?utf-8?B?R214SmY3ZlBhdDZ3T2pPVS9ldzB4WXRlYzlEMGM0amw0WmJsNkNMdzdPNkZO?=
 =?utf-8?B?dEJHTEFUV0UraTBiRXZ6VlR6T2NsK0d6OFFkSDVzVkNzcnlWV0lYZ1dnVDRn?=
 =?utf-8?B?cDljSmlpUUFIbW0wMENwbXdFekdPek9jZHNBcytSU3hpOGZmenpHSjF6NVlC?=
 =?utf-8?B?MXREWk1uY2VtS2FMcUozV3c2NHUwQlBZRGZoalE1QWNEbVNQNDkyWGt5MEJH?=
 =?utf-8?B?MEQ0czNXd3pYenRFeFlObEQxNkpoQ1BrY25GM3N6OEMrL3phVWJORUR5WVNH?=
 =?utf-8?B?V2lDSU4vSGVaSGxkcjJUZFI0emxNUUJPKzR0QnRxdzU3NTFmUk1HOG1POS91?=
 =?utf-8?B?RE9vR0c5SnNVVjlRYVNGejB3VVRIcVhoRHlaSFlKNXU1TzhtZHhOQjBGdS9l?=
 =?utf-8?B?bCtKbmRIcVFOWWN6VmJkc3ZhUmFHQ1orWHEyRDQ3NEllNVBZelJtSEFxZUhO?=
 =?utf-8?B?anhoOGlKQXEvMkxobGF6NXhadzV1a0ZXVVo3WEJDQjc5b0NtTjRXSVh6a1ZI?=
 =?utf-8?B?TVZDcUQ0MVdLa3lvSk5SZ3diMmFNYUw4aFBoQjdLZzZjUnpxY2F2VXJmcTBK?=
 =?utf-8?B?Y3dxRVpSZWhyR1Z5S1RCSkZ1dEhQMys5VmlicjhsZ2oydDdVQWJSSE9rQ3Rs?=
 =?utf-8?B?V2x4cHdiMENkUjd4WnRidHk1NVdWMTk4Um4xcGZnakZyUjYreVJBZDFKaStS?=
 =?utf-8?B?VVdkOCs2aEJUVXhxUjdnL2Z6M0dJQTVmdHcyNC9mVHFYaVRnVmZtcHBwbDZZ?=
 =?utf-8?B?VjRmU2dQM2d4bVQwelZFVXdoejlLczl5NExNL0NTaXliTmV0UWpIbXovazZa?=
 =?utf-8?B?RDVzZk5nSjlMNlM3czkxMnpOdjJQd1pHY2VoOVNZQkl2RVRkN3FsT1lBK0Zu?=
 =?utf-8?B?TGFiV3FvWFJqckJRV09odU1HMGZhcStGWlhQU2d5b3RWRlNnYWNQZ2xjWjUy?=
 =?utf-8?B?ZWVUVjViemxjRTFoU1BkNmVub3hwRHFTV2MrSUNhVTZXNURCUyt5bStmZStN?=
 =?utf-8?Q?FVlOOKjlZNmosLSUarpT1j6vP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d61fab-04bb-49ed-7918-08de1a88e25a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 03:27:15.0346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6Aojmv1AUsanRhkPqwKV7LUmDzJGyNYbMV5synD84qdDBYpt4jC1YItT7TDVG+d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8744

Remove low power mode support to align with the Rev.1.0 -- 25 June 2025
datasheet, which no longer support this feature.

Datasheet is available at
https://www.nxp.com/docs/en/data-sheet/PF9453.pdf.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 drivers/regulator/pf9453-regulator.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/regulator/pf9453-regulator.c b/drivers/regulator/pf9453-regulator.c
index d522715a7c74908b39880ce9f0bfc252a4dd4ba2..fded3e65b856f51be97d9d4b307a2291d247a21a 100644
--- a/drivers/regulator/pf9453-regulator.c
+++ b/drivers/regulator/pf9453-regulator.c
@@ -119,7 +119,6 @@ enum {
 #define LDO_ENMODE_ONREQ_STBY_DPSTBY	0x03
 
 /* PF9453_REG_BUCK1_CTRL bits */
-#define BUCK1_LPMODE			0x30
 #define BUCK1_AD			0x08
 #define BUCK1_FPWM			0x04
 #define BUCK1_ENMODE_MASK		GENMASK(1, 0)
@@ -130,19 +129,16 @@ enum {
 #define BUCK2_RAMP_12P5MV		0x1
 #define BUCK2_RAMP_6P25MV		0x2
 #define BUCK2_RAMP_3P125MV		0x3
-#define BUCK2_LPMODE			0x30
 #define BUCK2_AD			0x08
 #define BUCK2_FPWM			0x04
 #define BUCK2_ENMODE_MASK		GENMASK(1, 0)
 
 /* PF9453_REG_BUCK3_CTRL bits */
-#define BUCK3_LPMODE			0x30
 #define BUCK3_AD			0x08
 #define BUCK3_FPWM			0x04
 #define BUCK3_ENMODE_MASK		GENMASK(1, 0)
 
 /* PF9453_REG_BUCK4_CTRL bits */
-#define BUCK4_LPMODE			0x30
 #define BUCK4_AD			0x08
 #define BUCK4_FPWM			0x04
 #define BUCK4_ENMODE_MASK		GENMASK(1, 0)
@@ -535,14 +531,6 @@ static int buck_set_dvs(const struct regulator_desc *desc,
 		}
 	}
 
-	if (ret == 0) {
-		struct pf9453_regulator_desc *regulator = container_of(desc,
-					struct pf9453_regulator_desc, desc);
-
-		/* Enable DVS control through PMIC_STBY_REQ for this BUCK */
-		ret = pf9453_pmic_write(pf9453, regulator->desc.enable_reg,
-					BUCK2_LPMODE, BUCK2_LPMODE);
-	}
 	return ret;
 }
 

-- 
2.37.1


