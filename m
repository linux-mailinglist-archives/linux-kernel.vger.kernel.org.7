Return-Path: <linux-kernel+bounces-725252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 886D8AFFC77
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663B7645AB1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E78235079;
	Thu, 10 Jul 2025 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mofYLClv"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392C628D8EF;
	Thu, 10 Jul 2025 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136535; cv=fail; b=D4snvmx5If9uCt77Y4QtdYJzbVOrYDctL138TFO/16CsjpOznlDN1I+lEdO2uOWB0r0XdJe6rduAGbfx98E0is6HnxUxA2KXuxtnNBlEc9bcS51kpYn+8ZduULNellS03HIp9ZOZ+Lgt3PopnrHuupixCv0t/FXOS7tMWc634Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136535; c=relaxed/simple;
	bh=o+rrtinUGLpc08Ypo+sf5OlEi8wTIvDCB5kJXYTsXEU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qJ0hmbXAZtcWDK53EO9aEfIcGE89shSDwzueatyNEjH3ilfSCXAbiLccbajzjl4WSVeP8S1Mqo99F3THkJ01lazX3DgjVLf0wHpFznQuLf7qWa/go/45H6lcYuOoKUy60b6CtXZrVlcFxMJpTWuisbX5zjWDvUl6FMFEYx1IETw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mofYLClv; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcfRMHvVJ46zxYWmY0Ms7FW3neKXJHkqWzm84e/WJee/7ITakYf3zbHQpelgi7qSfDWuutYdQZQi6M4xf2wYYopfiF0Q3Nv/B1Z+3YBizVP1SErGQWGzSqL0pQpgvdpCkfb6+NKo1ZzQGc74UQtkSiek5x6q7mJlJGY9Xuvm7uI1k/TTbZ7udYT1rbFFzrLVb9njMKWGv42obEiDyx94WoRNGFrsuW2jwBDU1JG5GIsu/kBAkiHp8tuUh6mNGMKvJCp2ZhRFAR4haMvFELKPGsR2YtW+uPlDFbtQzER7KhKABPU6QWBKDF0sLsN2DLdQ0kYES+NppVk/KaWK7GO4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vewiXr1mwbVhzu8OEmuDfCl7UZucJubA5G40OkjQ1ds=;
 b=YsuCaQz7DaeXvNsD6VJ7G6e2AKZJJwiTUXIlCzz6IiJa6pBsut296rT4bycWUVd9OxeL3OeLL+t5Gqfe0CiUiheDOaSVNxhAPq/zG5tcAeMnl01jp2hM8+0F88c/+27i2DcO3V4LTe/rUcFU4ecQMSKk5YHO9JKK6/GQTsGU5DYfQcLOLAKvEo24KGrjv5TjNUFJyLxwqqXHLgaO7suYeY2QYcLUgBRJPN4aKauyJU+jIRTaKf6DYGIlMFOeQWqWa451ghX9ZJ8NG8WsVNLPbrFLGz778GePd5QWnT0AP5/e2DlLxLXFB+NRvmMuHWlCtwFXeMsCu0jiBye8JpbYzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vewiXr1mwbVhzu8OEmuDfCl7UZucJubA5G40OkjQ1ds=;
 b=mofYLClvvYP4g0rFmPlLrcvekYUukrF+Jn11ceFlINiP5rGxXzpaVKnN1wqYwNWAX/uQwkpwvL+8ycidhnj5IeZ6IU6Ks2kz+FWXCDwRLUe/4kVdYMAalmDWvf4+UJBlG1R2kKwvJXzgCnpcZPoAGHrXNiBCIi/ZX5CkiPgeDxlSV/V0LsuxK616rbb2KIt8L7b4LfnXaXEl9e4k9Aivv8DZXhgMGB/caV5kr/Ec+kgQ0GVCs8ZjfGO+yjZnbbgiSAGujcPz9FvrvfqBT0Rjm4VnVD9bgWKMbPLGxYyl10TQyauC1Id/uq6ekb+b+zmvmKoPtpGJPjakJFXIFvXTuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB11512.eurprd04.prod.outlook.com (2603:10a6:10:5e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 08:35:30 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 08:35:30 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 10 Jul 2025 16:33:27 +0800
Subject: [PATCH v2 2/6] firmware: arm_scmi: imx: Support discovering
 buildinfo of MISC protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-sm-misc-api-v1-v2-2-c3e953e34be6@nxp.com>
References: <20250710-sm-misc-api-v1-v2-0-c3e953e34be6@nxp.com>
In-Reply-To: <20250710-sm-misc-api-v1-v2-0-c3e953e34be6@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752136418; l=2646;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=o+rrtinUGLpc08Ypo+sf5OlEi8wTIvDCB5kJXYTsXEU=;
 b=dlFvSnrP2H30kKVZOIMeebqI5M81TIwsEXgIC2FBdrNIaaERtQX+5s0h3SszqGXbcOyVyC4O6
 NhAo+5YPM+SC+jBVHqEzFyjW2BJSnXSKED3UP6siD0/RLNqrVJx1rmq
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: MA0PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB11512:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ecf0ec0-6e8e-4b9d-02b2-08ddbf8cba90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzlhdWVmNFh6U0xQNEtxNktNZ1YrNUgwVC9yT1lmOURuMTBYQlpZZXNxWFBQ?=
 =?utf-8?B?Z3U3TW85cnk1N0N5MGRHMDZHMDVmOTluZk1yS1pyaW1IVWlLZ2JmOGlYdGs5?=
 =?utf-8?B?NkJKVFZGMFhtOHlzcXpCRFR0RG03bFRrVGxSQWp4MndDMkdrNDFRUzBKYWlH?=
 =?utf-8?B?d1RkajhyNXZldjA5YnRSblJITi91eW1jQ2VNZ1NTZ0lEeUtUcFBMV2ZPQy8z?=
 =?utf-8?B?MzRHcVFzbHpvc2NhMllucitDRjBXbEc2K1ZuSjVMNmpSYVl1MnBrT0NIM3V3?=
 =?utf-8?B?SDlBdzFFM2N3NjZEQXg5dUp3WFJqcThhSkZLdGhwQURVbFlPN2ZYVFpVcWdY?=
 =?utf-8?B?M2o0YkhSQ2lCRndEOW9XTW5nZ3d1ZFBiM1FyaWRwQTFwQU9ZM2Q4YVdiVmZm?=
 =?utf-8?B?Y2UxcXZqWEp1c01pcldRYzg2d05vbTVDbGF2QXllTEQyTDFvbThicnVOc0hF?=
 =?utf-8?B?QjMyaUd5dzQyS2xvRHRSajN3OXl0ZHFNV3o3VllkNnZKMHJ1eFVmZDF4WU9n?=
 =?utf-8?B?by9JTy9SdGp1ZEZCdzhmRm1lTzl5RXR4N1dNWm8vWFFkR2N0RXV0Q3lOWEhT?=
 =?utf-8?B?R0x5bGw5bnRkcmo4WXArajZVMXBRTzJROWR5ZVN3VGh2TXFuSUx1ZVZoaFJC?=
 =?utf-8?B?d3lsVjJoYm01VmZSN2xFWXArcVhPYmRkaFhvWjBMWU93aGxrcjUrdEFZMzRW?=
 =?utf-8?B?ZlczZ1pScE9LdzBqV0VxY3NaU1VRZzhqdjJUSDcxSUJESUpVRWJwZU1IZ3BH?=
 =?utf-8?B?d3FmbElmZEx6aGltbDhEUHRNQy9oK01ZVlRzdVlOaDBKeEV0RENQZGh5cHNu?=
 =?utf-8?B?WFYzWTE3dDBSUXduWXZvaDVVSnlzcVlITGpsUEoyWmt0QTl0dE4wY1VzeTR6?=
 =?utf-8?B?Vk1EcnBpaEgvL2ZwUkdUOW9WcXo4K1kzd0xHdFBkM3FVcUhYaFBaK2hKZzhy?=
 =?utf-8?B?MDFFbGFoQzNCUjl1TDlDWmlNcFAzc2JIbVdtdlRLblFEQUtGZG5STmtOMW9C?=
 =?utf-8?B?Wld4VmpiTjQybFI1U2ZQU3M3KzVueStVN2dHMFZpbWxIK1R2RVUrbzJoWUlu?=
 =?utf-8?B?RTFFVmRyN3N2YjV6QU9JTG05M2NadXJSNkEzdlVKNnczVTd3SVNMZG9GTUVy?=
 =?utf-8?B?ZS9pbVd3VDdEcjJuMG1keFRuV21OOHVRUG9zTmZaYmtleCs3MmQ4ajR5OVh0?=
 =?utf-8?B?YlBzdEl1MkxSR0k3R3BMWUR1ZjFwMWZCU0VRaVJ1SXlacHhhbVRHbEJsUWRk?=
 =?utf-8?B?QmFKS3lJbkwyOWhCaE1HSHU0RkRGMWNDV3RGUGRyU0k0cnUxTkdPd1I2UC94?=
 =?utf-8?B?RGQxTzd6YW5xWVRLNHRYUTNKUGlDa05jRkxYMGQ2cU9ub3djNnNxTnFlR2JL?=
 =?utf-8?B?RXhkbGlIWmpNT0ZMVXNyZ05wL2ZSSXp1L0J3OFgyY2VXSHVnTG43dytkQnY0?=
 =?utf-8?B?YjBhUitwZVh0b2RtSXNGZkRLQnErN2xtM2hyc3NvbWJyaGtwaFlNMkNhYkNS?=
 =?utf-8?B?Rmtjd0dFWlQ5TzZkUU1taVpmMXR1emlWYmRVaVpSbGw5ekxBUFJKR003MWpZ?=
 =?utf-8?B?TllWWGhHRDlUM3p1T21pbXBkSEd4REhMTUhQSGpBWXJwMmNuTkxGdjFuclMr?=
 =?utf-8?B?UVlDRU04WkY1K2FKUE1Za0piMnB0azdmRkZkQ1JidGh4ajNPVnA3QTdQa1hn?=
 =?utf-8?B?enZsdTFPRlVITis4ek9DQWhyNU1CVG1ZMmcxdXRleWhYWExJZHlRQ0xCNWtx?=
 =?utf-8?B?MVJQcVZMYjlWUFg0dVRXYXhzWkVuT25TcFl3NFROMHIramJiazhOZmZxazR0?=
 =?utf-8?B?Z21sZ3VmYyt3Q09GM0ZZQWp5R3B0bFh2MGowOTV6a1oxVVJVTDFHaXU0d2lJ?=
 =?utf-8?B?TU5UdE1jT0lUYXJhR2s1RFM0UzQ2aWhpMzE5TTBZVmhwUVp1UEpsNUNtdExn?=
 =?utf-8?B?YmxBTHdCWFhiUVZIZzRpZW4wbmM5ZDdVejlHMFBxZkRHc3YzNEZLZDVMZXl2?=
 =?utf-8?B?WTY4V1NBTXdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2d3VEZLaXBuQjhWOG1BU21kV3ZINmxmWjREZkVSUFl3VEQyTjJZUjJIRG5z?=
 =?utf-8?B?YXNDZ1BDRnNib2F3ckRPdnpNOG5rdXRLQWhFYjZUdlpsVXJiazdXd0VlY24x?=
 =?utf-8?B?UEI5WVRJaHJvQ0lMdlJrTHlmekQxVEhRZWE0aW96UmZ3bHVCbmg1bVloWU85?=
 =?utf-8?B?dzJ6OEx6dlVTdHV2Q3VSR3g4TFRyQjNFOGM5TytGQVhJSlFpbVhLWUZFdUpO?=
 =?utf-8?B?VmQ0S1c0T3ZUNHZWeDkxNmxteHNsblphTVFudW41M2xNanNqd2FQcFVnVjEw?=
 =?utf-8?B?SXJsc2tVYmZOcWFuWkp3bDZUTWoyZ01GTHpFNXpnRkRrWCtaR0pmMDMvaDRW?=
 =?utf-8?B?RTZWS1lPOWI0RDhUSmxlREhmaUp1M1BSeWwyUm5MSUJTVXNjZmVSbm4rUUwx?=
 =?utf-8?B?Rlp4WGZ1NkttMkZGMzk1blZTQ2Rjb1hPajVMWE1FemtFWEM5U2ZQSnJscnNp?=
 =?utf-8?B?MnNCQ0ptazBWMW5MdnE4REdQL1JCcjVJRFN1VjJiRlFhTUdPOFh5M1lzOWZ4?=
 =?utf-8?B?dGhCU2E0OXM4VmJzK0c1Vmp4OU5UMlQ5RElrQnQ2RFZuZzNSb2daRUhpRHJY?=
 =?utf-8?B?QkVLNUtaMUMyb1lweU51bEpibWwyQi9aakl0aXB5TG5GSTl2YS9DWHYrQ05k?=
 =?utf-8?B?OW8rTXE4RS81M3dERGpmcUtobElxTkN4Z1NaV1VxYWN2U1J6dTJoem82ZXlR?=
 =?utf-8?B?ZFU3dzl5L2xOZG9nazRvSURuaWtMU1l2My9jWnF0LzVic3pqT1ZZa2xGOTBD?=
 =?utf-8?B?ZGtVcW0zclQvVWlrbit2dG5VTFhWWkEvT0hSaFQvRm9DS2hzSHNDK1ZyYS9v?=
 =?utf-8?B?R1I2SU5vc2tSZGE0Nk8xZlQ2eng3TlFzL0VxeTlpREJyN251eWNpdy9QT0NJ?=
 =?utf-8?B?UG1XeXY0RG55ZmV1L1ZpT1liRG80cEVkakkwdC9DdE8vMS9UOW5CY3VvRmt2?=
 =?utf-8?B?YUtMaUVURXJVakxhNkUzVlFOTmY1OWVvcmFtdHI5VklmMTd1dEl6bkNpcUlr?=
 =?utf-8?B?UTlFUjB2TXByTFIxVTA5WjhrV2t5d0RDQ29VSHJSWjNPdkJna1VUQlFBRG0v?=
 =?utf-8?B?WnNsU3BYeUNHSmJpT0NOaUFjZ252K2tiK0tURnM1T1pjL09XdUV6dnEwUTNE?=
 =?utf-8?B?SWtieElNelRFOENSMjZwbXVmaWtNV29ERlVRYnBkMVhMY3N3N1pxQmUxQ3Mx?=
 =?utf-8?B?RWV0TWZXRU9RSWRqVXh5T1hCMXdieW9FQmpqeEgwY0s0Rkh1QVFqS244WXBF?=
 =?utf-8?B?cytSeHVnTlhlOHdJb21XUEc2ZWhXMUZYV1k4NmJjbkVTV2ZkYnpyZ0NyK2pN?=
 =?utf-8?B?MWxROEZ1czBRRXJNbTN1d2FMUFU1WnEvL0lreWxKdjN4ZVlGR3hEU1BYdXg4?=
 =?utf-8?B?cmYwQjhkMzExN3ROUWEreTFBMnV5NFpTam5zeGxyWlNPTXdYMWEvcEdxTS9q?=
 =?utf-8?B?ZzA2S2ZjbytUcFcrNXkwalI0cmRzSGNmVGtzUndhbEFwNnpiUDZoL1ZpTGU4?=
 =?utf-8?B?WkVnYzlvZ0d0TGMvYjRqT3pjd09GOU5GcWxjVU4yMlJ2MElGQnFpTDJhbFF4?=
 =?utf-8?B?bGIydkFqcXorK2svOGxNWS9LUlB6S1poSXJjZFZwSGFibTdhWXd3U1V0NEVj?=
 =?utf-8?B?NGx1SEdQTzdGWStDZWU3OFR2OElXVXNrdDBiWk5CM2dZUUQvakVMcVc0WGdw?=
 =?utf-8?B?aUhzbmwxdkpJT3BrdDFocm5SbHdnOHFlWW1DOWNFcFZZQjdLOG8xWXV6TnQy?=
 =?utf-8?B?ZXJBMWMwVU5WVGh4U2NmK2c4Q212NUM0blhnVUoxQ293dXd0Vy9FeE9CQmlw?=
 =?utf-8?B?ZWtNTmxqU2c4cVhQeVk4OWg2WStNbmxPaVEwTkhCcFhCVXA1QzhabGt6Qy9R?=
 =?utf-8?B?ZXhkYzJGTTlVeVhjbDVzSklGWDVIQTYwUkc3Q3R6MndZNTJwT3lKUmxUazRL?=
 =?utf-8?B?VFN6UVhZd1NrcHhrM0VPQVRsazhWM0RsaFFpQXZJaGhkcCt3QlFYRVhKL05E?=
 =?utf-8?B?MTIzYnRmSkhtTGV4U2cyZW8xWFAzZXAwUVZqa1M1SWRDaDh4TnJOT1JacGZp?=
 =?utf-8?B?cE95UE1zSEEyRkQvMnJ0VmNVcHJ6WlpPUlBpSjFQNmp0REl5R1h1OU02TmdT?=
 =?utf-8?Q?4YZ3Wc6clmP76IKPgOfGUYRc2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ecf0ec0-6e8e-4b9d-02b2-08ddbf8cba90
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:35:30.4296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H12Uv2ZpCsej4sV30bYausfBwk0yO8jq2FCiLQYOO3+KbF859jpeF5wmo+OSebP3pJxxwlJOXr7TISGYQEqj0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11512

MISC protocol supports discovering the System Manager(SM) build
information including build commit, build time and etc. Retrieve the
information from SM.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
index a8915d3b4df518719d56bfff38922625ad9b70f6..b301f09ab6cc65d286edb8819031d7f4c02e8272 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
@@ -25,6 +25,7 @@
 enum scmi_imx_misc_protocol_cmd {
 	SCMI_IMX_MISC_CTRL_SET	= 0x3,
 	SCMI_IMX_MISC_CTRL_GET	= 0x4,
+	SCMI_IMX_MISC_DISCOVER_BUILDINFO = 0x6,
 	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
 };
 
@@ -65,6 +66,15 @@ struct scmi_imx_misc_ctrl_get_out {
 	__le32 val[];
 };
 
+struct scmi_imx_misc_buildinfo_out {
+	__le32 buildnum;
+	__le32 buildcommit;
+#define MISC_MAX_BUILDDATE	16
+	u8 builddate[MISC_MAX_BUILDDATE];
+#define MISC_MAX_BUILDTIME	16
+	u8 buildtime[MISC_MAX_BUILDTIME];
+};
+
 static int scmi_imx_misc_attributes_get(const struct scmi_protocol_handle *ph,
 					struct scmi_imx_misc_info *mi)
 {
@@ -272,6 +282,34 @@ static int scmi_imx_misc_ctrl_set(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
+static int scmi_imx_misc_discover_build_info(const struct scmi_protocol_handle *ph)
+{
+	struct scmi_imx_misc_buildinfo_out *out;
+	char date[MISC_MAX_BUILDDATE] = {'\0'};
+	char time[MISC_MAX_BUILDTIME] = {'\0'};
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_DISCOVER_BUILDINFO, 0,
+				      sizeof(*out), &t);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		out = t->rx.buf;
+		strscpy(date, out->builddate, MISC_MAX_BUILDDATE);
+		strscpy(time, out->buildtime, MISC_MAX_BUILDTIME);
+		dev_info(ph->dev, "SM Version\t= Build %u, Commit %08x %s %s\n",
+			le32_to_cpu(out->buildnum), le32_to_cpu(out->buildcommit),
+			date, time);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
 static const struct scmi_imx_misc_proto_ops scmi_imx_misc_proto_ops = {
 	.misc_ctrl_set = scmi_imx_misc_ctrl_set,
 	.misc_ctrl_get = scmi_imx_misc_ctrl_get,
@@ -299,6 +337,10 @@ static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
 	if (ret)
 		return ret;
 
+	ret = scmi_imx_misc_discover_build_info(ph);
+	if (ret)
+		return ret;
+
 	return ph->set_priv(ph, minfo, version);
 }
 

-- 
2.37.1


