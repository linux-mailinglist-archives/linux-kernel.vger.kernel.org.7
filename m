Return-Path: <linux-kernel+bounces-856546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9300BE46F1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32B71A66640
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FBB32AACA;
	Thu, 16 Oct 2025 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U3EfpziL"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C7632AAB2;
	Thu, 16 Oct 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630454; cv=fail; b=Jqa2ASMUx8bSHMT19Hoj4XmOH5YBT87MEpS/807cLButteNyP9TI4oAvSRFSkrsNPr4TdA9m5SeWth6A2kV4xJIE5/BuzCrLhdsJk4/z+JUHRKQzYDyiFxbYpt319jKsLgkz3hg0i0bUaeVOeWp9MFmG2Uq7jAotK6758+Zw7BQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630454; c=relaxed/simple;
	bh=dYcvAmDC93BXEFvwR7Wi5iQXi17SC9Cz3fC3GbytFNw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gNeQHal+L7dL9ENJX+ad8GemTFiqneDMNA5I0McP7CDWTBuYIuEva+gmpykd3U/hubiTxdGwR37JclAhawmcre/cRcZbJL3jnnr5BafIPrO4v967pf4Rv1IP7oPvYVUTVHWLUgn6dvR/IwPpXj7c51palufhyi3Fw3HMhTI1SmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U3EfpziL; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGWTFMKCkAGRUlaol81xL2XBLTNKGiQJ0AaPFNjGceRTwOB+h08bvr7J3JJyVLkHXcbMorKiGBVTLvj0ldJCU+l25PHgD6QhrcgjarImgHS9MhN8HCzZgkm0py8OdIbJejo0HysPqZzVYcZpZyRNk+K88cSD8beOZFLftBYJNWVHNmT++KRlQEEpVb6r1pbWZhDSEFR0bwP/hL+LNvTMTIZsyAaXj+nz3u9tkS8ccvvFtiJ8tIOWkYev63L0adYE/VqQqwDDGDkR917tzrYwNOr4P9K9ZCI+kOwSrXOhQF+kYeJJXz2P1Eh9AS/ptKa2BA10h8CwHJUWOGKpClOLhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZUZ1Rbu/+8M6d7SlHfvr29xk1oef76PC+eYqVhaL/Y=;
 b=J2v5Z5Ct5qzos7XTaMPRftGZPLMrX6NaDiqyMbGjU043SgU9KplERAmlLJDrrt0UjLOBOmkxcPPLp2OOPUP6B9wu35oyG8CSP6NAziYhtjNrLTM8agJy/2tDMDDNPUgH3FVEFrrPxjCxMNX+mwYusA2YyLQMNTgN83uktosIcOu9z5/9XIQGH7kKSBN+QYB3K1YlxJ7X9WTIA0he7fJyZMhMzBgzZjTB7EpqYvWc3/Qldhk1ODIIxXEZoOt3YCu2VIep5kylhQyutk0GBx5YPyfkReTgwpTgbkSCtEjG2MufInB8AAAc0tW5Hin4EllVg8/MvYj9kIQwX1Vts3q6+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZUZ1Rbu/+8M6d7SlHfvr29xk1oef76PC+eYqVhaL/Y=;
 b=U3EfpziLoIq46zqbXfR5Q6cK0b4W8B46Z7ioXezsveXRKQLKoKaIFCLgQLlRE1kEH+aLyHOFOYWCy1XD2al1GmH2d8EaGdft74PQpGqrWPKCo69aB7AGXxkWLW19b+mLEvv/ylZKEqWxG/in+/U7y2kNQADNuer2wzWFMioWSpubmKQtOT7RY29SYnLNSFA4UmFnlS78T4ROe+9Rq/3AAmCOwosAP6qjNRO6ITTY7zpXYCJukvZw50m3UvCDGvyvTYSxxQ4Rx8LaFiUQ1XrPpYQdNCbhAqJY8LA2P0tVMlIZQ3CUnvrsVbzkSfudPVbNKR8V7fUWV9+U4pbuYYfNYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GVXPR04MB10069.eurprd04.prod.outlook.com (2603:10a6:150:121::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 16:00:49 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 16:00:49 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 16 Oct 2025 12:00:13 -0400
Subject: [PATCH v3 09/11] ARM: dts: imx6q-utilite-pro: add missing required
 property for pci
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-imx6_dts_cleanup-v3-9-baf2814f8a15@nxp.com>
References: <20251016-imx6_dts_cleanup-v3-0-baf2814f8a15@nxp.com>
In-Reply-To: <20251016-imx6_dts_cleanup-v3-0-baf2814f8a15@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760630414; l=1718;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=dYcvAmDC93BXEFvwR7Wi5iQXi17SC9Cz3fC3GbytFNw=;
 b=M/tYTCoOVxuKdWEFXaqBGrss3CF7iGkokozSy+1KD3Ql5DrPBPimJ1TfRWi8XS/2EXCNzgXLe
 Mx80se4h9AYDlUFDm4BHW3MaNNBGU0OajppC1IzmKZ2arlEywBreyWD
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:a03:180::47) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GVXPR04MB10069:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f574105-e29c-413e-8be9-08de0ccd2c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXRoaUdMdXYvQmNPM1owOU40d3F4bXhNbGJEWFZzNFJ1ajBib2lSTHY3SFAz?=
 =?utf-8?B?eGZhQVV0ZVN3VFd3Q2s1NUNyZlVEMjEzdCtpVHF0VVpsYlVqTzB6QmttYlla?=
 =?utf-8?B?VjdzNGZVak1XK2xWY0dxNW92RnI3cnQvblAxaXlOZlNBTHdsaURGdWdZaURL?=
 =?utf-8?B?SEV4Vm0xcjB2UlBSOEVMTTNlRVYxZlFiOXVtTXlFbUxjSEVZV2l6cTJ3U1ZX?=
 =?utf-8?B?TkY1V2ducjE3QkVLempZZjM3cEdJTWlSUFUrdDNreUtzMXJ0RldHdDNRQ3Rp?=
 =?utf-8?B?amhIZ29RRnNMQUZZMkYrdHdOQ0NGblhJZk9FcjBTUUJGMFFmTVNwN2REczls?=
 =?utf-8?B?bXBqVytkZEZCVmdsRHhseUh0OWl6a3lEZFhuSVRtT0ZhQmxPVjdiZXBXYXps?=
 =?utf-8?B?NmlVMkJ6ekh4L0lQQjRHQWg1ZWtCTlBRdXRNcnczRTNxWmZ6MGErRk1uSzNN?=
 =?utf-8?B?M0hrb2JXRGJVdmxTaU1XYUxJOWhmWUdzNmNNMWZ6Nm1ibGVscDdoRXVMY1Yv?=
 =?utf-8?B?WkYrR3BmcjQzMldxeGN6T2VMdTB0eXVnUnlNU2JBbFJSRTBtOVVVengzZmov?=
 =?utf-8?B?OXFSN3g0MEtGOVFicVE2VlNGSERNVVpHdVluUTBFYUE3Tk5vaktiS09adEp5?=
 =?utf-8?B?NXpQVjMwNWZGeENEd1NXdGw5OWVoMHRLWXQ3RDkxeUM5dmR4aldJaVpmMysv?=
 =?utf-8?B?Kzd5YjZCYWQxMmgramprRXJOWkdmWmR6a3oxRWJ6Y1VmVUpTRklBdGZTeG0w?=
 =?utf-8?B?L0JnQ0JGeFE2aWFEdTRweWNhUkxEbElzbUVid1M3RnVWcitkRGxHUU40dDVR?=
 =?utf-8?B?eWpKQjhYLzV0WFovRGIrazd5cE5sdWFoMW8xT0tySkdQdmRtdW5lLzIvZkVW?=
 =?utf-8?B?cUs4MmhMOVJQZUNVOHY4WFZkeXVVTUNzUWFYaDRVODFQMnVhQ0JtczdkWW5C?=
 =?utf-8?B?VlRtcW9DRVZRRmZwQktCdEcvNVZIL3JpdVVjYWoxS3UrTklPTFpSbkN0a2xE?=
 =?utf-8?B?QVV6RDJqRVhSTU5rNlJRSHJtVEZJWm9GWSt5cEpNNE1BaE9Cd2RFVDIyUEJC?=
 =?utf-8?B?Rm9Cc1ZFcjBLZks5c0ZhekFOWU03VTc1YnBUV3hySEE1TEZud2xwVzlCVmh6?=
 =?utf-8?B?YjJTUy9WTC9Sb2xxNTQ0Y3lCc0wybkJCT290cHJoa0draWJQYS92ZW9FLzh4?=
 =?utf-8?B?ZGMySjUxWUNrV04yUmZ3ZHV1Q2dYalZaWVBONS8zL2JzcWdVdk5qanhMT3d3?=
 =?utf-8?B?N1NnYWx0K3lHUlAzd0J0amVmSWo2Z2pSL3RYOGVjbmVPVjVDQUJITTYrVCtE?=
 =?utf-8?B?Q2RIOWtud0FnS0pGeldrV3VtVEoxNHV0cGJaaUs4cXlCdWVyR25xWC9BdEZP?=
 =?utf-8?B?ZHdyRDZ1clNvaklWSzZhUlFwanhiNWlMb1o3WHFYVGJxUjR5OGozU2k1YWda?=
 =?utf-8?B?UnVuTGY0WWVDRWc1RW1TeXFGU01GTFI0ck1qdFBsZGhyNnUyaVc1bnN2ZW9L?=
 =?utf-8?B?b3RSTVdyREhvcU5LODkwVVl2Q3RmQnI1eDE3MEordDcvOWUxaXRTcS96bGto?=
 =?utf-8?B?TTFQQmZpZXUyMEdySzRza0dsQnZTRE95WmYya3c0Skk2eExyMTM4Nk5wSUln?=
 =?utf-8?B?ZjBKaSsxakNZQW5SVjFhbmVTTmlLaGpJZDJjbVNacmxVcStXM1NJeXVnSXdZ?=
 =?utf-8?B?dm1WZFNHd3lOajhuQ2c4TUFvOXJPODVESHpUNUIvLzhSaXpFT2FtNHhCUGQv?=
 =?utf-8?B?RGJEUnZiVVVpcE5kSkUrbHkvT3FnelJSWFo2MkFNMGJQdVpEQVRzR0h0YXJl?=
 =?utf-8?B?NmowQmYyVkVheUJlVTI3UTlYZVdEWHMzSzJta2FZY0NHUlVjTHVyZCthc3FP?=
 =?utf-8?B?cUtVSS9vVnRHR3BvRTdJbGpBSTFJaWlZd3ZFNm8yZkwxeEVvQ1U4R0Jncldh?=
 =?utf-8?B?WDRJc3VURGRIMWFqdU9PbnBEU0RCWnA5dEtML0VKZDhEWVdHMzRzaDlDNEFN?=
 =?utf-8?B?TFdkY09iOFlBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjdEV2FCdUNVSEZoSmFuaGE1ZFFWSElQLzVINFJHaEhHR05GYXFERjhVcmtW?=
 =?utf-8?B?dW84RXhJVXB5TnFjZ1NGeHZBeHU0T1d3VEhkSXlZdUhPNC9jd2ZTK2hxUUVk?=
 =?utf-8?B?cERYL3NDY2owRkZ3V2RJVWJRNTZsMCtHcjRKQjh2c3JFMkhmZHA3SGduZGJM?=
 =?utf-8?B?NUVqc05LOTVUVG1hMVdpOFJWUlFFT3ZvNVNJdXl3MndCYlpNTzBnQWh6SEVI?=
 =?utf-8?B?MmF3ZFVpWWlFeUJkUGZIUFI2VGZsWStKejVMVjB1YVVGdTV2WTJSK2dLUVd4?=
 =?utf-8?B?alBXa01MSXBHa28wV0ZoS3lmNGd4dDZ4U214ZENKN0lFK1BRT0xLd0JzdVlm?=
 =?utf-8?B?ZHg1TWI1MXBuVWNITGd0c2l5SkFTTlVKRTVOdXhvcklMWElFTHk0M1pZTzRS?=
 =?utf-8?B?TjhMZGN6emRiWHlPb0crZFVFa3Bpb29nTkRZcEE4akN6R00rM21aYWJHWXJB?=
 =?utf-8?B?N2ZzK0svcEtodmNWck1XdjQ4dmZVbzQ0YW14dnZrakpMczEzVmhsVy9RVjJo?=
 =?utf-8?B?VGE4VDRIQ0wraTVuZGI4emRqMFZZSWJPZGxhbGh2QW92NXhnc3FBVmwxd3NY?=
 =?utf-8?B?R3kvUzR4aVdMSDlSVzNyRlE0SU5uRDVjblJHalk0R3VSWGJaNjRGanlQb2Zx?=
 =?utf-8?B?Znlyb1hLejJqaEYvNzBkQVEyYkxqOVpETDlJbHVwTDdKbUNRQ0N5MGVBR2w3?=
 =?utf-8?B?bVZpVGFPUFNuYTlBMlp4cEdkUG8vQkl5NUxubnBLVFREWllVcWo2QUZwZW1n?=
 =?utf-8?B?NE1hSXhKRWJpQmVUUlIrQnhFYWhEODZSMk5NTExoZFliZUVVVlVBcXhBdllO?=
 =?utf-8?B?REFaL2ZMUUdTSWxRbVJZaWEzbThLREdLbjY3SEVoOUhoQWFuR24yVzBHalJn?=
 =?utf-8?B?REtnckpEUTIyVW9JdGdSSGoyRExKbVhOVVgyZGpmVEJxeVJYNUFjVUZ5OTNW?=
 =?utf-8?B?OWkxZ01vbnlNT0Z5YVozZXljQ3B0cENDTUcramltKzNCVFptZFFUS0VGR3gx?=
 =?utf-8?B?OXc2UmFUT3VmcnQxbWxtOFRBV1p6WWYyQ0VMWDNVZlVYc1NueDFjUDR4K1Jp?=
 =?utf-8?B?QlVWSjA2MnlOdUc0UnJubU5Wa3pTV2NaVjBnbFBnUVFBbDZyK0lYTmZTSGxC?=
 =?utf-8?B?MFM5WnpVRDNBa1VjZUt2MjlKMTAxVUVGZEtGWkdLMGp4UkpGeGE2U0FuSGxy?=
 =?utf-8?B?ZWRhb0FiZmRQT0hIR1ZhVXBnWEhuNzVDcnJrdmQ0MFpyU01DOEcweERNNy9B?=
 =?utf-8?B?c3BBTVJFTzVmTDBYQmRDM0xKMDVpNEROaC9hK3NlUTh5ZU41MDhsdVE3N21y?=
 =?utf-8?B?dzZiMlFzcnVUcUd0ZUgwbklZQ1Z3SUNWNzZjekdoVDZsSjlmRTZSdml6MlNX?=
 =?utf-8?B?OW44cVZOdnpJSXFqNGczRldvT0IrZ0RKeWxBOGtuMXFmWmxVVUFEYUY3eFBL?=
 =?utf-8?B?OEhUQ1U5UXZrK1dnc0JhYUk0WkYwMXN6UWZETWtTQTF3VEwvMEhndXBPQWUv?=
 =?utf-8?B?Y3ZXSVBaMlprK0hBQ2tsclBnUktZRXNPVEZRQlpESk16WjZRNllqQ3BDejE0?=
 =?utf-8?B?bDdUTk9RMGxmYnZ3QllrUmE4bU1WVzFiZnF0c3h3ZWFIbVhtWlhKOW1JbUxt?=
 =?utf-8?B?OVBsSzVrNjdYWGRTOEQvWmxEcVZoblhPU3pwc28zQVFZWXFNZ3JwcUVtT1Zk?=
 =?utf-8?B?Y2RhdDEvRXNIcUtxYjRReXZyWE9Bb2NEUjhMQ3BjcFlqZDRkTmVZMnhNcTg3?=
 =?utf-8?B?cis2dWh1eDd2em51cnk1WnFoajJBVUlFeWRoQXl5TUhOM2t4ajBCS2did1Bl?=
 =?utf-8?B?SnJqNmZSbjUrSEhLVEZGaHNoWmZoSFlPcXNGcUJRS0VMWG95MkZpMnZKYlNz?=
 =?utf-8?B?c3hjeThZbFhoUGlEMFAxNVp0ejAxR08wQnRqc2V2amtGMmhvelhOVEM3Qi9Z?=
 =?utf-8?B?WThkYkNzdzRNYmVSRTdDZnJ2cGtwbmp1RWFBREZxb05zQ2djbU1iVjVKazk4?=
 =?utf-8?B?ckppdjUwUEdVb3RuTS9UQmpuNFNseWlMUWJrMU5JdTAyRGptWFZxemJpT0M4?=
 =?utf-8?B?aFJJbFp3TnhPbytMeXJvR3VQWjk3WVBMWlQ2ZE10bS9RelpTcWl5bm1sYnBT?=
 =?utf-8?Q?grnH3qC70UtwpLGd2tHil2df9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f574105-e29c-413e-8be9-08de0ccd2c9a
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:00:49.2055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/n9/1Id2jpDsASWC694tf1aUjidbc9+NL9saTdk6fPIsnjNmfEpHBm2sLM16+NUUKZR4ZPz6g+cLf1ygneuAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10069

Add device_type, bus-range, ranges for pci nodes. Rename intel,i211 to
ethernet to fix below CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dtb: pcie@0,0: 'device_type' is a required property
        from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
  arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dtb: pcie@0,0: 'ranges' is a required property
        from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
  arm/boot/dts/nxp/imx/imx6q-utilite-pro.dtb: pcie@0,0: 'intel,i211@pcie0,0' does not match any of the regexes: '.*-names$', '.*-supply$', '^#.*-cells$', '^#[a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z0-9][a-zA-Z0-9#,+\\-._]{0,63}$', '^[a-zA-Z0-9][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$', '^__.*__$', 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/dt-core.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts b/arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts
index aae81feee00dba2761f140fc2a76a828f69a8308..c78f101c3cc122f418b708b1c274ca11b586b65c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts
@@ -326,11 +326,14 @@ &ipu1_di0_disp0 {
 &pcie {
 	pcie@0,0 {
 		reg = <0x000000 0 0 0 0>;
+		device_type = "pci";
 		#address-cells = <3>;
 		#size-cells = <2>;
+		bus-range = <0x00 0xff>;
+		ranges;
 
 		/* non-removable i211 ethernet card */
-		eth1: intel,i211@pcie0,0 {
+		eth1: ethernet@0,0 {
 			reg = <0x010000 0 0 0 0>;
 		};
 	};

-- 
2.34.1


