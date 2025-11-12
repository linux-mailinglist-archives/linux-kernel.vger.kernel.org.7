Return-Path: <linux-kernel+bounces-897039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B866C51DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 461C24FAC83
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E91030B508;
	Wed, 12 Nov 2025 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YQr0F/0f"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012063.outbound.protection.outlook.com [52.101.66.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3134F303A23
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945513; cv=fail; b=qGuCuR++qYCs1Av0lKRRK+G6WkHQE7hmlHXEOPNQUA/o7U8ag3zHLzHjb65d9wCu7zZ5QMs0XP7tHy3Vqs5QPUrIwXSJ8JXxgvJN5bIl08gNLjnnflYW5k7bdBMxzNAjXuugb7c1rNmUjzwSEOfZiBIt/o93kzJVRmvDv/jV7ZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945513; c=relaxed/simple;
	bh=9ncnatkFKAscn8Z4toj8WWGHgxvAyUF+6laPXNKqcrk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UxMciSleJ4X66ZDb0lnAB/qS9Rbl90E7CJOldpdm0bRjPsPlXV/vaCg1oXNzFmd+KDye69mc3GFUcesxjoRdntXhb6wbwknIdwY2pqQJMXU2vgFbUVceRjIN7b3feSsaDGmafm+n06lV8vIIUwaFY3f+NO+27xTt9Q3/3ni04OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YQr0F/0f; arc=fail smtp.client-ip=52.101.66.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRcq6r8M/XKXL6Zl2syR5iqKjD6lWhuvBer5fCw4u9WWJfMjpbRimob+TqkQe4s+0NpRA23cT4IDVMUOUGljXkwljKFoHVIisS9NPUfNZRTCSNMPEjNyJCKGdmQq0XNSLcYaWfzWsi40tNECqUJKPUPybLta78MR8z9LuL3BJQkw0ZsIwghNnDp2I4KT8taZY7q/guPep9PZPkTK3WZEGubP0ccz6ksGy271RZqglg0vBSPY6tNeIXoRqNLlI2LbLruCm7TrdNBLhMc1Uhi8VkTzyIqzXf+Ir/rbrospfz0WRMacV390t1bObkbJFQI+6wcFcMvRP0aCSiwltGioVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZTYJsn8GGKDPFKp0meT8Z2gKxRinY9uGbuiRihFmSA=;
 b=vq5jF9eWFAjAu3xUnKeOxIZPLL6CjeDwRoLZzDX4p45tLm9kwDE0n6M/ojSVv+yYOEMY+9+YTH+48uh9SZPNqG/hYrRVAyVt8nWe/Op6uGt9HOEJA+3x5RUAnIXa91sVgkpF2LqD7u2dYjD033gs6IOIrvIoOhf5LiYZEWCP2LRC53Ra4i1FL1arRNUOt50kBnRobvyfX9smhLqT500jMarYLjfaWe+NhbDEt/fwZ1B4vLVp8q3gx8feCBwG/Zu1SZ3V14pF76Jim01OVPfTJwEjFdk0JMXzcKOhsZdNGsGb/X69AqIxkw4vhExYguoUNrDxJ54EwpI297ItavkWAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZTYJsn8GGKDPFKp0meT8Z2gKxRinY9uGbuiRihFmSA=;
 b=YQr0F/0fkZhyDK6th5h9a+aclBNIkoQ7g44cJ/c1JGdUSZNqC28rw1xlBeh1S5nkhXX0eupV0lHOfaVBb3Q5LueFB1We7sCYo5M5vVeZu0UwxxIFx8M9cD3FMVL2p0jSl69uXjnUUvt8akH3fhc98zOiSCsKzEH6u3Aif/8Ivt0rh+bUJ3Hb8PknfU0K8uNkdorvY0gP5un4WAY52tHkeExAtD0mZWXhrEvRQGtu3zVAT1GgltOhPL6ktBFAjhKdQkvXZ0jl2POLbVu1s2rNb8cFc8ryrD4i+eCsa+92yuhkXGeWDbC0FUOC1cZ3zRjJ+IkAhBSul16FsxfQ+NSFmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AS4PR04MB9364.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 11:05:06 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 11:05:06 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 12 Nov 2025 19:05:10 +0800
Subject: [PATCH v4 2/5] mtd: spi-nor: micron-st: move set_octal_dtr to
 late_init()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-nor-v4-2-e4637be82a0a@nxp.com>
References: <20251112-nor-v4-0-e4637be82a0a@nxp.com>
In-Reply-To: <20251112-nor-v4-0-e4637be82a0a@nxp.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>, imx@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762945552; l=1582;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=9ncnatkFKAscn8Z4toj8WWGHgxvAyUF+6laPXNKqcrk=;
 b=koP1UzvGzWyadTAF8WmNNa/Zh3qQRlbA8UjhXvOQN7fhhdvsli8T79sfxoX/vT5gZb/0z6/0a
 HZECjfRTGTLBZLNvQc7stEgmdrmzC9S+5YPMkvteZlH1jvAKgs3LPRG
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:3:18::26) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|AS4PR04MB9364:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c9b0ed3-fd36-41cf-c07d-08de21db567a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWpQZDdGRUtVZ2cxRExHZ0JBOEp5RjJiK3NvcVBGQ2gwcWhoTkxYcGxHazlU?=
 =?utf-8?B?VDhBZ0NlSnBVR2JXbXhib3prNXpSK0FPd09pTUhwWWVIUVovWDN4VFM1SlhC?=
 =?utf-8?B?OVIzUGhML1NFL0h6TFJ3bTdQMkhCQUhOeWRTY1Uvb3Y0anQ1aHRMM3FycEo4?=
 =?utf-8?B?QlZTL0x4eXB1Ynp2TXNmdWxwamprcHpQdDJzTlN4SFZ0S0ZZNEZ2YXlUL2dL?=
 =?utf-8?B?UHMwcStOZGVxN2pJU3pIbzRxVkFDc1Jic3grL0VjM2dkUnhYU3VodVdIRlhv?=
 =?utf-8?B?L21SQzJYSkswT3AzNjBJWHpTYk9wazRDQzVYVFFUd2Y2VzVUdGEyWGcxUy8r?=
 =?utf-8?B?dzZpZTJ5czhRVmNtNklPREdjbTI5K3IvZjFxakxDbndjM293OUpGa0RQQ0xr?=
 =?utf-8?B?d21sajZENDd1Wjlaa3NzV1l2bkdMWEgxZG9VUHk0cXBQekl3TGZOMi8zcW9X?=
 =?utf-8?B?RGtBNGxFa1NVU1VQS1FIcnV0ZDhzUitYaGlKU2tuMHN5Q0srRnlYcXpDUVFP?=
 =?utf-8?B?TTNHOG5jWVl6T3kzU3pVS2JnZmhYUEpRYS9nc28yYlZZTWRxWVlmL2w3bjVk?=
 =?utf-8?B?MVBJMkZlNFNiTnRoc0Z4RzQyWHFub0M3bUtRNWxCNHBvY1B4SVVmL2t5NDVH?=
 =?utf-8?B?K3g3STdzRFRQZTdOQ3IwS0tnbk5sa3Mzek5VQmdNL29SN3hvZ2FUMUNRUzBM?=
 =?utf-8?B?dExOSWpBZnpFNUNka0hNcHRoNUVjM2xmVHEwMEZRd1ZPVG1DZC96R3pKd0gw?=
 =?utf-8?B?MjhEVGlNWWU4VmJNOWQ0VytTL3ZadDUzSjBBdHdMWjlZa0FpTTdqVXFyZ3Bu?=
 =?utf-8?B?ZWszT2dwdnRnTUtYaWZIVXhEOUUxRU8xVHRxbk5sbFhobmt3bTFHTTNQM01J?=
 =?utf-8?B?cmphMElTeXEyRHpJVUU2UWlMdVl4Ulo3U0lOdU1RN2FuaTBVeUJ3UmxFT2l3?=
 =?utf-8?B?TFc4YkRBOHlNWkZMblNXVk9JbVYxT0hncmVJWTFzakNmaE1qVjIvSUpwN0xa?=
 =?utf-8?B?dEZsU1RaZ2EybGxiRHgzVUJQTzV6eGxpOVdkOG15bmVXdzdpbUJVMXhNa0d1?=
 =?utf-8?B?UmFWV2FxaGh3N2kzWjJ3S2hXaGw2ajNKWlNDNVZ6TDE5NVJkaHFTNGhqeDgy?=
 =?utf-8?B?V2dMcThKMFZLN3h4Z2RZUm4vdk1jaStwZmVtU3BQb0U1OVV5QXBzY2h4d1Zl?=
 =?utf-8?B?V0xtcWFZS3VUSDVYRXB0cHFDK3NQV2RDRVNYOXNEUXdka0tvaXM1SEQ4ODZV?=
 =?utf-8?B?b1poL0I2N1E2RENtczlkVGxwSWVrSUNWbUkvVi8wdVFla0Q1ZTBXRU1TY3U5?=
 =?utf-8?B?M3BTNERTVTk0VWFJYTJOdnpZTkxzbk5jaFdZeXMrSFdlL01QcGoxSmVmZDhX?=
 =?utf-8?B?Y25aYTMzaXY2MDVNQlk1eUgrVnhEcEc5S3NpQmxObmxWY2FNR3B5M3FSNGhq?=
 =?utf-8?B?djVjL2FkcWZweGdDU08wTmVZdW5aNm91ZWg0WlQ1a1AzaWRIY2VJalZUV1kr?=
 =?utf-8?B?MjlTdWRmUThzRFFOMkRCb3pHWmJoRElMRE92SHZIL0FSRWMvQkV0MVF1bFVQ?=
 =?utf-8?B?V3BSQkhqTWhRVnV1YWNySnFSWTFvVkJtbWpUdEVxMnJKQVo3VnQ2SENnNGdX?=
 =?utf-8?B?bHBkbE5tT1puQjMxN2tWUGx4MnZnc0IxWUxzdUpQYktCWFE2RTF4dGpDU1pR?=
 =?utf-8?B?WDdPV1lnMlVzTXdmMnFISmxSbkxDWTNVaFRIUGh0MUIwZjl5Zmtna3duMlVP?=
 =?utf-8?B?UGpYV2ZVSWgxc2dSSVpQZ3Y3d21td1EvaEtMR21ub3lYMnhwY3JSSDVxNE45?=
 =?utf-8?B?b1owKytyTVpwa3VUTzlaU01GWWZJYm1jQm5IZTk1VDZtWVkwajNibzB3dG9s?=
 =?utf-8?B?V1RJNFY1NUZmRC9UQ0s1ZlkrKzg5Zi9lZVRscWo1bGYySy9VUkJqOTROamdt?=
 =?utf-8?B?UFEvQWtzSW41Q0hSaFF1MTdRa29qbitEZTcvL2lNY3ZiLzIzN0twcTFrN2Qz?=
 =?utf-8?B?RjB3N0dNTENLREZ5QVA3S3Jkalg5S0FtMVk5Q1FzQkNyYlFxUGpOUWFMcHB4?=
 =?utf-8?Q?8PITPD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWhDdFh5UE9BRXd5K2M5Y0dveXF4Wnd3Qy82bGRRbGRpU3J2clV1bGlmT0Jk?=
 =?utf-8?B?ZmVLT0VlSmE3VkN2K2Jsblc3YkNRZGtKL2UyY1hXVjRRZEdzRjdsNEhPcmtK?=
 =?utf-8?B?cGhqTlU1U1BoS2tVNGZ3M0VIK2FSbGVtbTBGQzZCVzhtR2pLLzlpRU40Z1hD?=
 =?utf-8?B?UlNWRG1VNk1wOVBzYXJOQlRXWjFveGJhNENMN2FESFFMQS85RkFFbFJuZnFD?=
 =?utf-8?B?LzhvUjhCeC9KdTduckhNak5JNjhDWGREM05nRWVnQ0JnM2NhMjlUSzVZSUxy?=
 =?utf-8?B?NFh0NzZwNHZTM0NNTEJWbHRGNDBVZ1Y5c0JNTDhGMlUyRmtEbzd3RmpMSG04?=
 =?utf-8?B?cUJYeWhyMjJEUkd5UTQ3SlhmR2ttTkUwQi9NMUo5Rk1jcUY4elJYQnB3cGcx?=
 =?utf-8?B?UjNlcUFtbDkrZEZDUFdqYTAvdUhidXVRT2lnVitDRXFLbmVrRkUzcm5IaXBx?=
 =?utf-8?B?VVJBdDhhYjlhd0VOVjJDeVoxYUsrakRsTTFyQnNPUmJacTc4YlBqZk9WejVl?=
 =?utf-8?B?aG1kdGlFclhYVkM2L1pBUXVyZ09aSnpiZCtRejhNaDFsMS9zNE13RWJGaWtx?=
 =?utf-8?B?Z1pIcG9Qc1R0NWl2ampnMG9Bam54Rm1NZG1FcjBiYkpOZTJEY1U3U2V4ak41?=
 =?utf-8?B?aGFVTEhNL3FKQTBvN3VsVWhrdmhqNS9mNmVhVVVINzZRQ3ZhNmlFQ3lXYU4y?=
 =?utf-8?B?SmV4RGtzN2ZldmVpSkVOSjJzNTZSekdqa1hFZE80cUJxc3dSVmJwZTAweUk4?=
 =?utf-8?B?cDV3VUhFZ2JSck8veDNYalRnSVQwRG5FbEpkTnROR0tTQldWU3lnc2p6Mkw3?=
 =?utf-8?B?dDRxU2h4dFdiZ24wVFNTaGo5bWJQblE2em9rM3FBZXVFUm1BeU94TVpORDRS?=
 =?utf-8?B?RGZyTy90dDRRcWJXeC9ZVnBEcWd4SHZFUS9NSm9tYXFVSHBnOUVRVWlQZGo4?=
 =?utf-8?B?UnBqeXNSSEhHaU9yVU5ZKzFwL0tXVmlSbUV2aWM5bXdza1d3NWhpV0hCOHpj?=
 =?utf-8?B?cFhqcEY2b0RnZStGL1VVdFE4bzU5WUZFM3FTM2VnWlNQc0dKbmtCRTQ4d2V1?=
 =?utf-8?B?UGs3N2ZBOWZEYWx2MWlGUmVaN2M5bVNMR0NZY1BoRnhCVDBzYlRvMGRLV3Ev?=
 =?utf-8?B?dU1kbmNkaWxxYjNLMGdCaW9DT2ZlZEZKSzBiZXQxVXNuMUdCc0FYSGRrMXNl?=
 =?utf-8?B?alhNT25SVExoQnVIeDJNNnpXNG9wT1NFWXdhelRwWVFhNnZYVEFIbmVnVzZQ?=
 =?utf-8?B?Mlc1a1NsTGI3aEJVajNXSGVOYThtZlBYL3QxU1FIbFBnMExOcW0za25qc3Iw?=
 =?utf-8?B?bGI0dEoxc2JxZnNSRHNYeGQ5UFl3cDFWc1VXL3l1MTZjRXV6ZElrbWh5aWVE?=
 =?utf-8?B?S0pLYzRNOHRkU0plbERERWZKODA5M3pWQUc3a3pnbzVjZlZMaWNOamI4UHlP?=
 =?utf-8?B?TmI3a21MZ3JhTHBhMDBFVzZHM1FaMWhBcFRPMHVkZEt4Tk5rcU5qOXBZWGVm?=
 =?utf-8?B?ZUNuVndmUTV4Y1luVGlMcVU5Zi9qMXQ5YjRjbmlFc1FvNC8wUVFHejRuVVhn?=
 =?utf-8?B?OUJlakxWMkNSeFNZTm9xbXVyT0VxUUN5YzdFcDRER1N6dzRRdjEyTEpZYmtq?=
 =?utf-8?B?TGxtRmJxWlB1QTlQc1hOUE5VbW0rKzMyT0lMT2ppQmlXNWQ4WGdBUmoxWUZs?=
 =?utf-8?B?WFY4UEF2bnhiZFZocG1MUzIybnBWSTBZZE40ZmFWY2s1bnVqSlNRcjM2aEhM?=
 =?utf-8?B?bWp5d3lEVktrcEg2OXk5ZHZsYXJjSkcyVG1MemN3QUxvaXhWazczblpIQy9j?=
 =?utf-8?B?UFlxUlQrc1QwejdMeVJEZFhBd1FDRU9NZjJxMGtuWXhpSzdvUkVWcG1LbHJ2?=
 =?utf-8?B?UzhZUmNIMWd4NEc5Q2pMSThtYmE2bVp2bUNQVmNsNTAzaWUrRGN5MUZpSGFh?=
 =?utf-8?B?SEFoVEd6T3c5K2lJbG5QRUdqSERaQXpUVWN2SWhHMUsxWjB5N2cyQlY0RUdE?=
 =?utf-8?B?MWtpbkZUT0ttdVpuOGJIamN5QmZQV2dsK3FIVFVSdFhNQVVvb3JucEY4TE5h?=
 =?utf-8?B?cjBVb09zTUhTcGxJRm00cHVtNHZVSnpXUjhRMzR3Ym5uWmJXVWdBRFZuVEVl?=
 =?utf-8?Q?4p8PXlSWfYXF15j3rdk6uIRxq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9b0ed3-fd36-41cf-c07d-08de21db567a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 11:05:06.7893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vG+1KUaLzJAncqXSVSReWqkkXIyLGcoH2cS2H2YlnjIp6rqEVW3azrh+vX9KjB239IQeS53du4OX0e+A1ugT0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9364

Move params->set_octal_dtr from flash_info->fixups->default_init()
to spi_nor_manufacturer-> fixups-> late_init(), this can cover
all Micorn and ST chips without repeat in each chip's flash_info.

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mtd/spi-nor/micron-st.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 92eb14ca76c57f29ece1edb3fe652c56d1c2888f..81a9bead1434056cce0893c97bd35ea248c15894 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -159,11 +159,6 @@ static int micron_st_nor_two_die_late_init(struct spi_nor *nor)
 	return spi_nor_set_4byte_addr_mode(nor, true);
 }
 
-static void mt35xu512aba_default_init(struct spi_nor *nor)
-{
-	nor->params->set_octal_dtr = micron_st_nor_set_octal_dtr;
-}
-
 static int mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor)
 {
 	/* Set the Fast Read settings. */
@@ -187,7 +182,6 @@ static int mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor)
 }
 
 static const struct spi_nor_fixups mt35xu512aba_fixups = {
-	.default_init = mt35xu512aba_default_init,
 	.post_sfdp = mt35xu512aba_post_sfdp_fixup,
 };
 
@@ -635,6 +629,8 @@ static int micron_st_nor_late_init(struct spi_nor *nor)
 	if (!params->set_4byte_addr_mode)
 		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_wren_en4b_ex4b;
 
+	params->set_octal_dtr = micron_st_nor_set_octal_dtr;
+
 	return 0;
 }
 

-- 
2.34.1


