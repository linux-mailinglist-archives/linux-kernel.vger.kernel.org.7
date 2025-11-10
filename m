Return-Path: <linux-kernel+bounces-892452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 854CCC451FB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 096FF3468C4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031AD2E8B76;
	Mon, 10 Nov 2025 06:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="XKiN4CIS"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012005.outbound.protection.outlook.com [40.93.195.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88479223708;
	Mon, 10 Nov 2025 06:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757427; cv=fail; b=DwEdXo3cDsc/p7jEgAGMEO7JP8h34ZgAjvzSGc08xP7bIk8IYxubs9ZKBNrpllZXcacZbDdcwSgGKvnNQnzTyTLdDZyO7MQnmTgYFXNFAL2EhttU/mzYsCce4svmZG8hW77yWmCqp6LLaCSeV1pY5ck8FTz5VDrqBBXNY0FuBDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757427; c=relaxed/simple;
	bh=JLFss5TVQE7JQH6gq/VMcYYr3jt+HFNMN2/XqfTmrcc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ClV62S6HWzDsfKLgKXGfdgvmtWZMBXtFgyM6J8NRNdH5FK67URigpM3j0j+i1wXdILB6UUpW1f8SODmyY/tEgG2+s3ONdbiWdrrIQ+LlTugZYY84PkgqLtWWSObW0GM/YHjBqweSNsiJnaqwP7J6CveQLBrna9toXvZD2ncHv7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=XKiN4CIS; arc=fail smtp.client-ip=40.93.195.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKD0DnJs6e35Z5qqej/MrAcgGZjzCpSIG6Zy6yW7nZmd/IBoALVTtIKWHnrulCyohVKhHLdw3EDUF4xtGLN5Smc5z6dGYAAuWtaRl8job2pzHdxlEI/NCle1YjTAK6BWbjr7Fr7dPGwBCojwXeeYKl0qXeg79HqlMVygbmMHA2ovytEwZGwjuPEn2xnxQg/nKYpOEAK1W7atSi+x3Wl5ymMuOQLBjEUM6+Jj8a3ZOMRbvpcRsMS3Uxpd+KJmiOQwQcIYdWv3JabJu6AXrjPZPleXwycQYfNcruHC05z3cffjB1hTalR472nfCGemDWWwvbbcdT74efAT7ol2NeOApg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VpqPZUs7n8Pg0pPH6o17XsF91uVt4id5baBtWL2GYs=;
 b=E5i4pTrxDjkOpPGblnAn56vWZA9624XprzloDL+MZ+V7YcnIPg2natb3HGBjQ2ne32Ml/Bw92rAwqTf4SgEws1JfZ+FkfguwtX9ZoyDTBZ6W2BrzS61QqZ1PCZHs53kAQej9V431C5NpGHK8zLjGPE0S8IiWoYEdyhYzhN8RXfRptIuCN+Ax14kqmE0XyyDkPt7ycbCjSpecKQT/c6R5rFUd2YtcBtwIahEb0u/DE/reZ50+ShqAwJaoSzIDUe0oXOZunvMdmZfNjpgn65tSHXqnDGsEMZt2+p/T3XteXC9fgEHMUx0tgxSKqLYv4CS6359d80QEX07mLX5izKPyCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VpqPZUs7n8Pg0pPH6o17XsF91uVt4id5baBtWL2GYs=;
 b=XKiN4CIShTXRQT+es/nk+t8l1C68yPzxvH4xTc4nXlIc7BV8kW6XPCCuHVz+nhQ6+uuskRVo9hbiVMes/eJoFRR/F9Q8KIqxd8EE7Oo3PNohFiJMRWCow2N1SGk/iOI3TqUHhvIOSTK6zDX0LsNRjeIogELcM6J2mL/RjZJ1jog9SvSZNcyR3ggPi00vnYoOrSjapNtp+rKx7/0nnE7yI6tZqIjFpn+0wakNyfax9dV1/F+5tz7FGmrstH3cz5ffajSzUwN+G8c2P7M6QOTwyyscfVc8czfV7XNktZhPHDA8FfTV51BVkoYcEdMgjbxFFMw9QZEwBw6Z5jD6c7auzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by SJ0PR03MB6240.namprd03.prod.outlook.com (2603:10b6:a03:3ae::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 06:50:22 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 06:50:22 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: [PATCH 0/2] Add support for Agilex3 SoCFPGA board
Date: Mon, 10 Nov 2025 14:47:56 +0800
Message-Id: <cover.1762756191.git.niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU2P306CA0008.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:14::6) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|SJ0PR03MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: 214ee626-5ff9-4d57-5774-08de20256af9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWg1NFNRNUlNeUhFWWljeCtETW40YjlCV2hXZEpXeWpHUi9aYmdpNHF5dzNR?=
 =?utf-8?B?Y1JmTStVdW9FKzhHRkVCZnU3YWZiRGQ3bmN5K21Sc2VGYVRUS2NTYTVsdHJr?=
 =?utf-8?B?TzFEWEtSVXlUNVpnYmllUVZuQ3QyNWMzRVo0RFJhMXJGTTN3endRMlJHQXFK?=
 =?utf-8?B?a045WmtBL1JDQWY2eUtpTU9UamZBRUc4ZzRIbkE0ZWF5NkF4SEwyMlEzZmU2?=
 =?utf-8?B?ZXdzU1F6dnBRMHVPRkIwYnpycmk1bkVHRFowVjZCVDRRVVFwanJoZVhWN20r?=
 =?utf-8?B?eERUc1NVT29hRC8xbzJvMjduUHFZNVJ0T1BuQU5ZdXRocFltYnpQWkxnWTBN?=
 =?utf-8?B?cVlVcms4RHNhRUc1ZlhtZzhFQUF4YzMwMWkwd1NRMmlDYlpObjB1d2F0VVY0?=
 =?utf-8?B?ZjNmVHVWbTM3QUhTWUk1ODNFcHE3T3FETURyNGR3QmJtcWhRbitnSmVvN1NS?=
 =?utf-8?B?dVlUdlJxTGZ5ZWIyY2FBNU1acE5YUkVTbncxOXd4L0FzRTRIMC8ybVBnRzgz?=
 =?utf-8?B?RFlKWnBQdUtZR1lEd1BTUHc3NXUzOThGZXl2cFhhMGhWeVdFcUJ1ZVpDYi9I?=
 =?utf-8?B?TjhJMUxZYVU1OTF2SHBLeGpCNkswTGs2M3JaTVVJWGJzMkNrVHEwbzFEVmxp?=
 =?utf-8?B?Y2F3UGVsZnpOUzdXVVlkNTFyMkRxVzlSQWdtU212NTREOFdRTkgzL1lrSVVU?=
 =?utf-8?B?NmtZRmtMK0EreFo4dWt3OEJWa0ZhSFEvUTBDc2hjM2FFcVRrYUlnZ2F3U2V1?=
 =?utf-8?B?bVNYSVRYNHMvNmNRRkVCV1NKUm91blRLYnNiWGdJMUlxdUlwRXYzZVNpQ0NO?=
 =?utf-8?B?NTdtVEg5bDJhL3J4aHN1OXVVcnFBbFV2aXdDMXdqMWRuNkFHL3dwaG01L3lj?=
 =?utf-8?B?MXhrd2Q2MWswZUttRnFhYWIzc2RUT1EwZVRSK0xwNGRjNXc1d2VPNXlEaVZz?=
 =?utf-8?B?eGttZTI3MW90bEd0N2ZsSmhqVmYwMkVsTzNkMG82UE5xdUExMEEwWUk0RUdO?=
 =?utf-8?B?OWpQMGxwck5oQlFlcEdEYWI5cUJOR2g1NkU3cVEvUkZKendqVXQ0d1MxQ003?=
 =?utf-8?B?eW1PcFc3MXVuUzFQZVQwcmVDbUV1Qm9wckZZbHRHZnpNVXI1S3RMd3RFU1E3?=
 =?utf-8?B?WEdQdnY5N1UvV2c5b3JRZmwra2NkZ2MwKzAyaHg4OC8yRnBkR2FWbU1LQ0JF?=
 =?utf-8?B?ZFRiRlNoNHIyUjhMVFVNT2xXQVNHTTRoZ1RER2xydW1LWlpoL2VzcWlWWUVN?=
 =?utf-8?B?SzdXUWI3Rm9ZZ2xROFRRby90S1R1bFI3ZnVRZXQ5ZzlpTHQ4NlFKa09WbVVh?=
 =?utf-8?B?alVZMHZpSkMxWmloVW1FaHNrUzZKOHdZSzdsVG1SaDAwZGhkcTQxUWY3QVZt?=
 =?utf-8?B?NTRyc3dpSDhpKy9VZC9zMFhOYjcxbEd0cEEyWWQ4dzVGOG9rZU5kMjJ6YU9t?=
 =?utf-8?B?VTF4SVRHUFJ0NGFSSUxIT1haTmJvcXpRTzUvelBLS2dOQVkzZWlKNlRkZjBD?=
 =?utf-8?B?UzN5L1dKaGRlM3d0S1U2NDhvV2huRTFtRHdOeDlGS1RxK1NpYVJ3Z1Npd2Z4?=
 =?utf-8?B?QVQ5d2R2OUx1RWxDay83VUk4NmZCY0FmT0kwalJDS3VTaHdQdHZkNUJPOVBZ?=
 =?utf-8?B?bkMrVDRTcWFDcmxKaTRxbmJIdnNCdnM4M3dOZ2MwUUs1UjRWMnFDK0lRbEhw?=
 =?utf-8?B?aGt1c21DdVFhYzlvYXV4UkJZUlNrVXdjVmVWTEpPeDVucFpUeWY2azk5ZzZD?=
 =?utf-8?B?Tjd6UlprbEJPUm83RTc4Skt0U1hISFMybWxnbEpNcmZrcGdFdE1UV2lFZzFx?=
 =?utf-8?B?MkhiZjRlV1pkZFVKYmk1SjNON3ZSS2kxTU9UcGN5SWszazZ3N0RNYXV4enhC?=
 =?utf-8?B?c2ZXVDR1T0pLMmRrY25ObEtpZ0lnd24vNWVBNk4wT1NPRll1a0tZSFRNOExu?=
 =?utf-8?Q?j0qugXsz0dXFpVKxC8ZRRfM6KyKVHC5X?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUFxRGUrK0JtbFQvTXVkQ2wwNm12cUc0UGhaNHdodkxGVDVUZll4WTdxRHcv?=
 =?utf-8?B?b0pkSzgyenJVMjVMQmdFcW9nRjhBVjQ4aWZtUUx1Z0R4M1lXOHN3bVR5QXcv?=
 =?utf-8?B?di9qakx4dEFNWU53WGloQWh2V0hDUk5HSG14NXpWVUZsak5zOE5KRCtXOHg0?=
 =?utf-8?B?VEd6Nm53Tk9RL0xRK0svS1FTVnA5TTIrM1NGTHVvYWVJRTZYV1h3dDNUWGVi?=
 =?utf-8?B?T1FJWFpzVmdiK3dkUThWRS9ST2xBUXh5eXVLckw1K2U3M0x2djhiUmdtRmJM?=
 =?utf-8?B?YUJBV0JOYTgxcmtETlN0NVRqL04zTDFua3V3YUw2cDl0MFpMd0lidXcwbi9T?=
 =?utf-8?B?ZUhOQ1I3UGR5Rkx0dEJDbVovN3JaK0h0WXo2NU1xZVhZWVE1VWpVSjhhTkVY?=
 =?utf-8?B?QnBmbVNnV3cwNnhxYXpGUlBSWHNmbUU3VkdLMTlwNXk1VTV6bG8zWkFGUklB?=
 =?utf-8?B?b2kxQ0I5Q0crZlZvK1hvMXdLaVQxSUpnOU1YN2lpTGlmVU9yWXVZT0l4cWx6?=
 =?utf-8?B?T1ppVTNMZFpzQ2V4c3U4YnlaZXJGSFlweG9WM2ZacGp4N3Q4WUpIUThoZGRR?=
 =?utf-8?B?MWY5c3d1L2tsaUUvT2JGVnJWWndmdWpEV1FIV0NVeklmR0lZSHMrejFNSlpt?=
 =?utf-8?B?eGpMeUVzVW1xQlhRdEhiL2hTVFZRcnNEVk5zL0xyTXA4VDl3VlBRTXB4aG55?=
 =?utf-8?B?aVFvTlVhUGdERlpQOXN1VmxxVjNORVhQL3liMnhjcmRvYUhscU5CejdxM0pL?=
 =?utf-8?B?SEdQbFdMWkxMUGl4dllwSFhPcFFYZ0pVYXlxV2hiUVlxMkRiK3pmZVJGdHUw?=
 =?utf-8?B?bzhEK3RFVWJ4SE5JWThEd0ZOdlBNS2ZUNldiTmRCUXlHektUVGI0RHZkOHFP?=
 =?utf-8?B?dmllLzF1NmRzdmVFeE1yUXJVa2VNQkxCVGd1c3BEOXZtMERuYmx2eEsxcTA0?=
 =?utf-8?B?dFhEQm44dEsxOTNmeUNjdVJhajhYRFNqZFdGSkdSTUpHUnhMMVcrOVpWOWpj?=
 =?utf-8?B?NHFSdmcwbklocVFzblNYeThIcHloV3dyVXpvOWVqNzdhYzNzT1NDNlA1YSsr?=
 =?utf-8?B?cHE1YTlQaS9yN3pTOFVESVVBeWNOZEVkaWdVclIvdGY5azQ3ZEQ5bVBxS1pv?=
 =?utf-8?B?NzVyK1MrVUg2Y2liMzU1R2NiempsSDM3UVB1Y0hIZkpoa0kyb3diaE9CVEZD?=
 =?utf-8?B?cmRYa3hBeUJtT1c0dUJ0TTVCRTVMbXNLMEJjdGRKSXVKSzZOREZZQUM4QVVX?=
 =?utf-8?B?cWFKWm5oZ3A3SDBIWHRtdHpCMktTc01IMkhOOE9RaDVDelhqYVVFN2llYzdw?=
 =?utf-8?B?UWgveXRjMU01QTF3c3hiVzhRSjhweGVmZ0JxUzgxZGFxbEpPd1dOOUpXMDRq?=
 =?utf-8?B?VjlhTVdvb3VLaENyVHF5czg1eWdxSXJLQjZ1RUdBRjl3SzA0OG8yR05QcDVG?=
 =?utf-8?B?RkU4YTZ1OC9sSy9tRVdLckl1VGpjWWRtZTA1Z2NmZGxIZ2xzelJYK2NYTS90?=
 =?utf-8?B?ZWd0YllnTTVoMmFiVzZqMnBCYytYbWhSMG1WMVFvYWtyeG5oaThRck8yTitY?=
 =?utf-8?B?NVVqK0ZmU1g0eEljUnptUUNUVEV1d3ZQYnBzN0dWWGtqUXFuTkVUUzZLeGRT?=
 =?utf-8?B?NlJINXBlYnh5aEhkcWlEaWIzNjQ4T3pKN2JvUkl3SXBONm0vSHF5SmpwNTQ0?=
 =?utf-8?B?KzVHSWhQMmNLYVJ6SHl2eFNBQnVwOWc2aU1RKzNZdG1nQUxERjBtTklmK2JB?=
 =?utf-8?B?d3JrWTh2eHo2c1oyTmJGSzIxZFF6N1dLZnVPa1ZBN0w4eER1QjNrZ1V1c0Zi?=
 =?utf-8?B?YWQ4WXZqRnhWNGJaS1FqbkdFSG1kQnJNdkx5ZCs4NS83d1ZLNVFGWXR4aU5T?=
 =?utf-8?B?Rmc2OUZRTk5nN01ha2lyYmlDRy9NR1ZtajFFeWFHT0dEaWp3YjlKT1psblpK?=
 =?utf-8?B?MExzQi8vZDBubjRITUp2dUlxUG11TzhFdk1qWlQvU0wrQXBRZVhMdXRSYXZR?=
 =?utf-8?B?aU9NUmxXbm1wRDFIMzlOWDdUTWppNUZuVkFiVlFoV0FWYURsOEl2bEdHdkkr?=
 =?utf-8?B?UFlPLzF2TTJSeWFkQTJuNjUwM0ZJMEVKZytUSVU1ZXU5b1krQU1QMVpuL1Iz?=
 =?utf-8?B?ZE9ML09NTGtwRG55d0tURU9NY0JaVlhrZ1VaOU5xcmN4c0lYcG5GWlo2NEt6?=
 =?utf-8?Q?AeHdpP3G4FiFgUt3gjyCty0nRX3ceJzfBjO9q++Fzgr2?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214ee626-5ff9-4d57-5774-08de20256af9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 06:50:22.6050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mf4nahoCdpnvNuMoGREYglF/XMyY9x82wLgrpdnrW/EeHSpSdNwy3/7HG7oUVXaD7urJoVL5rg1LSnh3SS6uoRQ33qhRtmmMrPwWeQHiiqtu6coKak+kUun8mIgp2QBC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6240

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

Agilex3 SoCFPGA development kit is a low cost and small form factor
development kit similar to Agilex5 013b board.
Agilex3 SoCFPGA is derived from Agilex5 SoCFPGA, with the main difference
being the number of CPU cores — Agilex3 has 2 cores compared to 4 in
Agilex5.

https://www.altera.com/products/devkit/a1jui000005pw9bmas/agilex-3-fpga-and-soc-c-series-development-kit

This series includes:
 - The addition of the Agilex3 compatible in DT bindings.
 - The initial board device tree support for the Agilex3 SoCFPGA.

Note:
The patch 2 depends on the series: "Add iommu supports"
https://lore.kernel.org/all/cover.1760486497.git.khairul.anuar.romli@altera.com/

Patch series "Add iommu supports" is applied to socfpga maintainer's tree
https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/log/?h=socfpga_dts_for_v6.19

Niravkumar L Rabara (2):
  dt-bindings: intel: Add Agilex3 SoCFPGA board
  arm64: dts: socfpga: add Agilex3 board

 .../bindings/arm/intel,socfpga.yaml           |   5 +
 arch/arm64/boot/dts/intel/Makefile            |   1 +
 .../boot/dts/intel/socfpga_agilex3_socdk.dts  | 130 ++++++++++++++++++
 3 files changed, 136 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex3_socdk.dts

-- 
2.25.1


