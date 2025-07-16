Return-Path: <linux-kernel+bounces-732741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B42B06BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 04:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E8B1AA1317
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 02:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF00B272E7B;
	Wed, 16 Jul 2025 02:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="yHNy+duy"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2105.outbound.protection.outlook.com [40.107.243.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1992D052
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 02:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752632047; cv=fail; b=sSmknPXZEtrw7x+2xxW8RjS9+cAnOqwOu/vdsr8HKK3WmAFgcd2eKbNVkRlIQWK3builZ8NM1SEbrG27qZoN/o1xXo0SCR98JzG9bj6zvUwTr19nWZ86e7pe8pUlUd0g8O9xoAbIogPVvsXqgTevh+rwceW2UIItqO2eUOj7V60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752632047; c=relaxed/simple;
	bh=dB+7xDgM3pc+R707ypC/aFm61tCIo8Duoh5JmEzAois=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fYI0vpHCCBRZwWwn+0iOaD3HtGl7xkrfnKFvPRvmw6EdMRzFMiecia06Z4KxzBw0QtYgmIpS0waFomnQdPJDU4mua2YRHiXyJXiJ1SquIxcArvcVb3lbrgxFxAO3et0ByDmO1luY/UcOK0RY1yHwW0iUKp85/gRiXIFZaMCfZ9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=yHNy+duy reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.243.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pt2FkmaZGLCTlc5UW57CQRXbuGSbHOv32XSZyMHSzX0raGC769CRlYDlnnh4lpKqgdugEVzrf3AEyFRzGmdGWzlEKJkitCZNn0DurBHTOHaQroBR/m1Ef29jREQeut94xKQRXuftuTRTsNJFviqUegEjpgFuHD6PEXHiYdcmHCyMvekuoHbc5HtNeCHUIAAoRVjNEdJiYGBz+YX45ykkTwHz/+eaEUVjUGFuqmEw0wQFR5SGb5IecDZKpw9VR8Yun9NgWMsJvwwK4lCUh+krI7qGD2WfpvRo9h/9D4MHzvD9kVxoij7l8HnqlAS9z2Mn20DP8NwzLlzwlxqOvrEkqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUn4j3TN4lDjiFBklWLDEo41uqS///rTfSJshNiiJ0E=;
 b=D3ZF1P7NeQb6qEsTZ3z9Jb62zFqNKiCctPCIDJYsc7a5sv6r6QYV1Z70swZeIiu3ucy7jvb1YFEXfzgwdtXdnMlaSe4H45xoTd+t7rrXd2yPuFj810uqscVCkuUbDaUd4iB1xQBffYsIjWHkGDWz5CgST5m9o5TrCvWPnYStFL+53gJLc7fggYJDO2C7V/C8nvJSAbwZb6Id0ea9sS2IXZsol+MT+wwvqqC/YXJRy6iEjmFE+mg8/wgsZE9TSqjOgYTziGavs91LN2Rbs6jFkH4jA39OMGVUfQRUrcGJOX9OiVZvKpURzH4Wj7b55WQde5abXJayyXKfNZfAEaCe3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUn4j3TN4lDjiFBklWLDEo41uqS///rTfSJshNiiJ0E=;
 b=yHNy+duyvCfcy3RKRBTFI3OnD0+kYOeM/1xEab1CIdDADv+NhOHyBCUuVspkC8Fg/Po8XakkUeStd/wodtufS180PXtG5AFRQL/m3KwGS06ai1dtfJM1Hh7uRTBB5XBdWzXXMP4uz6rLqA6TsqiDh0UEJ7ZSI1DftM6PVmDMraA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 BY3PR01MB6721.prod.exchangelabs.com (2603:10b6:a03:36c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.32; Wed, 16 Jul 2025 02:14:00 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%7]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 02:14:00 +0000
Message-ID: <d4ed8553-6a57-4b56-bc6e-ecadd2d9d75e@amperemail.onmicrosoft.com>
Date: Wed, 16 Jul 2025 10:13:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: do not scan twice in detach_tasks()
To: Valentin Schneider <vschneid@redhat.com>,
 Huang Shijie <shijie@os.amperecomputing.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: patches@amperecomputing.com, cl@linux.com,
 Shubhang@os.amperecomputing.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 linux-kernel@vger.kernel.org
References: <20250707083636.38380-1-shijie@os.amperecomputing.com>
 <xhsmho6tl1j2d.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Language: en-GB
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <xhsmho6tl1j2d.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0031.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::9)
 To PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|BY3PR01MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: ee32878d-3b8c-4310-1b50-08ddc40e6d76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHJoeGNiMjJERFdhNFpxeWZlTkpUUndoMDJzZy85bHVRV2JpL0lxbjRzSXFY?=
 =?utf-8?B?T1UrbExsM3ZXS01mV3lmUkxyRGNKM2dhOFFhbEo2RGo3d2QxMGdmYVg2Wlhp?=
 =?utf-8?B?MUE5aXBRN0JuU1dMRVJKdThtMGF0OGNXSTZDMWZWNXpxYmJYT1I2ck1WN2JP?=
 =?utf-8?B?VkkwanhMTEVXaUdudXI4bG1qNEpGZlhTQUczSVRGKzRybnd2ZEhlWWN2c2Z5?=
 =?utf-8?B?akJtdUNBSnNCczZxYnFJVDBqSXViQnVHR3lKdkkvY3R3emFTUnRJaUt1T1Rt?=
 =?utf-8?B?VGhJa3g1YWZTNUh3dk5jdmJOYXJRQ2pOUGJneEJIb2FTYzhGbFVtZ0t6OTcz?=
 =?utf-8?B?NzJmMmQ3Vjd2dENmOG5Ra2JpcXIyZzZXYldhc01GcU5GdDBEMEY0dDNXRnRZ?=
 =?utf-8?B?TTJuUVB3WmprcS9FdGpzTENBV1FuOXBrTnJyQUZhN2VkNmZZcFFUQmRiN0JR?=
 =?utf-8?B?UkxmRkU2ak9qbldOcnNTVzh4d2VMVDdNTFJoZVpnUGRqV21VN3lHY2w4ODR1?=
 =?utf-8?B?cU9rNUtjckJhaGw1TEtYL29YQWYwQ0FJVFRzU0JLRDlwMU5xS2Jic1JpYXNI?=
 =?utf-8?B?YjhIRHVxTjVGb1hqVDh0UUxMdzVML3Nmc3h1TEEvK3g3Z3crSlpHOUlMM3U5?=
 =?utf-8?B?S04vdGIyUjNPTEl6ZGxldTlpQUJFUk4wMXVxYVJ0TDdhSWhrNitZSW9VM2Mz?=
 =?utf-8?B?a3R2ZjJkKzFmSXRlZjVsaWw5L2NhaXEwUGRaL0o5VWl4L1FlWDJTdFdXOVhK?=
 =?utf-8?B?NkVzZlpMTVhWdWVRekhqNkJ4MkhtNFpqRzcxbTJyQjJLb0xRWVVhRWMvU2JS?=
 =?utf-8?B?TXFwUjJWUjdvU1o3MkI5YkszMmhmQ2JrVENHOGRFWE1uY25oNmRpRi9UYVd2?=
 =?utf-8?B?MitrNlhYZFJlZGdLWjk5LzJhSGJzV01ZMmdCeUVLQnBLWTBUUWd1LzhYa1Nq?=
 =?utf-8?B?c2JUWWt0dW8wRjJkeHZHd1pBd1Noa3RFMWxaS1BIQ0tvSURaeHRZbmtWcncr?=
 =?utf-8?B?cGNGaUVyY2tjZk1ReFNvL2JRTjNzSXJZNWtZTVY4SjUzRjllRzBkS0JyaTEr?=
 =?utf-8?B?eitVNUluWGFCNW5XTTFCU2UyajU4WDQ1UDZOaytRZEUybmRHKzNJUnp6WVlB?=
 =?utf-8?B?bHAyRmdxd1BZWHF6Y2ZmYkluRlM1V2J0Y0QyVUNrd2VWeStROVBrV25QR09V?=
 =?utf-8?B?MmpuM1lvd2Q5NVlHbmhQOTR2NkgwOG5rTkxuazk0VmtSNXNNQnpISkZZa1BO?=
 =?utf-8?B?cFJRWDJDcDNrbDdXNHROL1YzVnZJcEFCTzMzcUFiY092KzliZDdyY04wQTFI?=
 =?utf-8?B?dXdROWFvWHJHU0tsM0Jjckl4WUN0WUtLUTg3ei93VWpVaWYvSlFIMnBRd1FV?=
 =?utf-8?B?ZjF1V0ovb3lELzZ6QmpaZ3p2czVmeDljenpFZ1loMFJpVWNMQWRlWVNDYmVl?=
 =?utf-8?B?YUZFUDQrK1paaDdvZzVEeHo0b0Z3YU9JVjhaU1d6bU8ycytkR1JtL1lTaE56?=
 =?utf-8?B?N1FpRVlzSmhsZkpWZnFRVnI1SmFrNTIxR3VUK1BwTlN2d1pEMzZFRkxCUFRR?=
 =?utf-8?B?S0ViWFVNK1NZWWhhSTJEVXRqSzNpWjlUTTZqaXVpc3V1MVFDc1BhZExaSXZP?=
 =?utf-8?B?SS9zQzhmM0VsT0VmNThhK1hBNmlSVkJ3R090dmk4OHFjckNaclVWTHBjRjNW?=
 =?utf-8?B?YWVRMHZrNTZ4V2Z5MUpWQzFsc1gralNuS3RFYXVBa0FQL0ZDSFBHcWNSMnRE?=
 =?utf-8?B?SkFlb2xLQ0wyR3A1Z1JVR2xKazNjUXpEeXMxVHZ5dHhIY2IzYnpDRGtEb1FV?=
 =?utf-8?B?elhQWW14dFpwQnZKL3lQZmZFaU5WTE10UFQvbGJtZjN5R2FmS2Q0eHF6RmVE?=
 =?utf-8?B?WDFZZ2ZlOW9iTlFRNitwUmg3K25uVXNOUkVheEZjMHVvS0dvNzFWSjNPL21x?=
 =?utf-8?Q?NtvymRVGQ1g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGhqei8vcnJ6VEdYOUZNaTZPZVM3MGhSQ2FEZ05MMy80UWNFcUlHaU03MU1J?=
 =?utf-8?B?WVNDM3VXQmtERkhoaUI5NGpBNmJDaXpTVklxeGFjMGZyOUFDK3l3ZFBZc2p2?=
 =?utf-8?B?eis3Ymtxd2NDQUdWNkd5TWpndEZzZGZSVHpEQTMzREE4QlVxMWc5b0txRm95?=
 =?utf-8?B?ckxTK2RyQ1g2RUJVZjRuM3JQK1NzWHlsRldZMGlUWC9mVkMybWlrUUM3dFli?=
 =?utf-8?B?cVhFcGk5bWoxVXlDUlRJVEZTOEErdjVJcm5pdjZLS210K0tjc3pHNUQ1aTNh?=
 =?utf-8?B?MWJ3UzlabTduQkZBdDBGR3daYjhrMjZKNUxUVUk5QUhuanMzWkJHZmJ3VGR5?=
 =?utf-8?B?d3JtQW1oenM5a2FOc0hNRHp6U1FDOHFNcW9KYTBkaUJnY0xJYXR1TGlOWG1K?=
 =?utf-8?B?aFBpakQySkREVVppYVlqcTZmbGVyWVBjQytQSUUvWUdSUUh1RktCaUMzRzBu?=
 =?utf-8?B?eDlSaG4xNFpJUWdxVFhsa0ptK3Jrbmk0M1pyQ3ZxOXh2WmNrbjdwbXFlZmk4?=
 =?utf-8?B?OWhmTjZWOG81ZTY5SmdVNjNpdmg5ZVNsNnFmMllOSHRtWjMzNVFHMDViRHVI?=
 =?utf-8?B?NGM4enp0MUl0WjRCREY4S0hnNFZlaGFySU1hVVNGRmZvVWZzbXRTM3FVdFpi?=
 =?utf-8?B?M3FobFI4UHp3cVhiRFc1RDhuc1ZTYVgzTENZK0NNdzV3RGFqNWxxN1BnenNr?=
 =?utf-8?B?Zmhab1hUTms5VytNTUtYUFFYZmVPd2hLTjZtNUUzbXRpSEtXY3cvdEFYTXdH?=
 =?utf-8?B?ekgySDNiSG1rcjh1bDgyVSswZ3NtZS92bE9OWWdKQWNIUzJ3U2Roemxxc21F?=
 =?utf-8?B?bzdpY2VFWUZwdUovbEdoZVdnY0kxZ0cvNFJTUWRFNHY3RjhvL2xhUVVjV0hI?=
 =?utf-8?B?VG9jaE9EZ2NoMVFFSiswS3d4ekhPZ2hNRGRWaGNyTTIwQWk5QzNqMERpaDIr?=
 =?utf-8?B?NExQdlQ1dXRUOG8rZEg5Y09tbGh4L05Za3pCT0s2SVJZSk1BWU1TTHRtY29Z?=
 =?utf-8?B?Y0c1bitGOElpMjdZUWFubkVwRnpOV0JEUTJlbDM0cyszZC9GZnpha0F6MUs5?=
 =?utf-8?B?eVVYb1IwVFVERGxrTjZBZTB0c2lvc1p5QmMyMGxpMkRQaGtsa0pjUnJLdklI?=
 =?utf-8?B?TG4xZE5hWmdvS0NxcTlTSkxoTFV1QjdqczBHMjk1RkJ5UTBWc3pQT0E0bVdh?=
 =?utf-8?B?eTE1bExXelQxSHk5Qjd4Rld6ZHhUTzRyRTREdzJhYit4Mm45aXZiMnZwTVg5?=
 =?utf-8?B?VCtIcTM5QVBVL2Z2Vm5qMnJUUW1ySFdsR2ZCSlBWUHZsWjUvcTdaYWJOdXh3?=
 =?utf-8?B?cDZJb2dDbmJMVGVZRUU1ZnBjbm9uNmE5WWwrSUZyL0wzc0xlYWFnSTRZVjZw?=
 =?utf-8?B?czRhSGxUYmhrUEh3M2s5dUdlb2M4em51NDRrZjNSNGt2Qk0xaTVoUzRNNmMx?=
 =?utf-8?B?eE5SQmtDRi9ROWE2VWpRc2srRy9sSTljZWZwYjgwcGpLL1dWSVBRTk04MUZl?=
 =?utf-8?B?U1JkaW51Q2NnYkthbW9ZQ1hkdExQMGRnZXJJNXdqazNsY05HNjNvd2hUSnpS?=
 =?utf-8?B?cDlQdWhxQzZLOUFOcGF2Z1l6QXExczJPeHp2T1dnUDdrSis3V0RwTHpBc211?=
 =?utf-8?B?Z0JNdlBkNVpjMjc5akxTeHdQajlKNTRZY1ZsYk9vbldSd3FJQitRL3VSemFw?=
 =?utf-8?B?dk5OdEJMc1QrYUE0QjM1UEIraHJPSXdRcVVQdVV1WDhsN3BXeUZORG9nUDZ6?=
 =?utf-8?B?TzB5bWJwQXFMSy9uNE5BMjFOTWtTOTFWdmtrc0hSZ3lLQWtpT21UNDV4Tkll?=
 =?utf-8?B?bTk2SE9vOWFoWFhXNVJzY1NpOGduZ3FWUVdCdFI1RHJobGtGL2Q4SmkyK3BQ?=
 =?utf-8?B?aG1GNnU3ellFVndrSDAxblM3b0xvQjUzQUFGV0dEbUE5bnFSaGE2R2FoWk1n?=
 =?utf-8?B?WVZreW50TS8rUWpBRFZDV0o2NEt0WWFtdkErUEsxQVBNU3ZYMnFDL01GQ091?=
 =?utf-8?B?bkxsK2E0WUM1a0FqYWQreFFlRnpJRVZvcE5zWDM0UVBDVFpOcnZoVTFyUlZ3?=
 =?utf-8?B?alZWd09jMzh5R2hJT1gzZkxSY0JMTXp6djFXSnlsZ252RDFuVnY1Y2crUDlF?=
 =?utf-8?B?VFlUTWtnZ3QwTk1WaFFCWUlaclQ0L0RleDEvU1FlcWJUTE92RjFpM2ZzamtK?=
 =?utf-8?Q?43JzZOrukr2VzNfo1Cu5ReI=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee32878d-3b8c-4310-1b50-08ddc40e6d76
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 02:14:00.5254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zeEM4v2xI29otBctIkDtYFqQQ7WIG9gh31u5RBa2Vs1o6OSXS6WfqEvFQxzKhQoaywH/ecdB7G+4BR7ztIM1rbjl1UOJxS4MwM9hE0MC+4vUG8QEW6vwAqkQFNrU5bgV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6721


On 2025/7/16 1:04, Valentin Schneider wrote:
> On 07/07/25 16:36, Huang Shijie wrote:
>> When detach_tasks() scans the src_cpu's task list, the task list
>> may shrink during the scanning. For example, the task list
>> may have four tasks at the beginning, it may becomes to two
>> during the scanning in detach_tasks():
>>      Task list at beginning : "ABCD"
>>      Task list in scanning  : "CD"
>>
>>      (ABCD stands for differnt tasks.)
>>
>> In this scenario, the env->loop_max is still four, so
>> detach_tasks() may scan twice for some tasks:
>>      the scanning order maybe : "DCDC"
>>
>
> Huh, a quick hacky test suggests this isn't /too/ hard to trigger; I get
> about one occurrence every two default hackbench run (~200ms) on my dummy
> QEMU setup.
>
> Have you seen this happen on your workloads or did you find this while
> staring at the code?

I found this issue in my Specjbb2015 test.  It is very easy to trigger.

I noticed many times in the test.

I even found that:

         At the beginning: env->loop_max is 12.

        When the detach_tasks() scans: the real task list shrink to 5.


>> The patch introduces "first_back" to record the first task which
>> is put back to the task list. If we get a task which is equal to
>> first_back, we break the loop, and avoid to scan twice for it.
>>
> Potentially more than twice, no?

yes.  it maybe more then twice in theory.



>
>> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
>> ---
>>   kernel/sched/fair.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 7e2963efe800..0e9c8ae68cc2 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9443,6 +9443,7 @@ static int detach_tasks(struct lb_env *env)
>>   {
>>        struct list_head *tasks = &env->src_rq->cfs_tasks;
>>        unsigned long util, load;
>> +	struct task_struct *first_back = NULL;
>>        struct task_struct *p;
>>        int detached = 0;
>>
>> @@ -9481,6 +9482,8 @@ static int detach_tasks(struct lb_env *env)
>>                }
>>
>>                p = list_last_entry(tasks, struct task_struct, se.group_node);
> Small comment nit:
>
>                  /*
>                   * We're back to an already visited task that couldn't be
>                   * detached, we've seen all there is to see.
>                   */

Thanks, will use it in next version.


Thanks

Huang Shijie


