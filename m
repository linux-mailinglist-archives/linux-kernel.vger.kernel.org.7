Return-Path: <linux-kernel+bounces-834288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87524BA4580
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35F11B243ED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639761F4168;
	Fri, 26 Sep 2025 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="haUhhkMm"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011064.outbound.protection.outlook.com [40.107.130.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97DF1C860C;
	Fri, 26 Sep 2025 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758899168; cv=fail; b=VdcBm/oManeJJstcqxztZgHhDULEIutQRS8a0khBAPGwscdTVC2gj+zBc7Yb/OBsFvTMLQIPFXQAVwsiy1n1YkFozNBAX7FGIifMhkOduQ56ET96RorNVkvx04kb3f/DdiMi8wfY9eWPceZOw4iZkoecdem7N/8dzV5S7JnMMkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758899168; c=relaxed/simple;
	bh=p8ByMieyHd8xhybHZuwhL62HeyTNBY85lOMLDA60/z8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=kAZydTLfii75eNKBuBHLhO1uzXQKREimh+jjvPiVTz8pQYiliNbXEoLDJXJR6I+dQHU4wDusoBwDxkkU90YzQsJnuOqhoymnIAOfiDQeRR+wPJLFuSlHAwq0r04WXjT1mb+qICxuDqpBEiNDKdJoZdWAL2wwFbiAlkAHj267e3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=haUhhkMm; arc=fail smtp.client-ip=40.107.130.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrfS5TRRo1PD0IGH+0kYHwrzwVZxQ0JN7aZZ14q931N4fqLssdSOycjTxmUjzUOE4ZNAAjc8DY2tbucUtvDkyJwnYXEUErW4KvuR3HrmxqchJ1UB5gZNg5yjgRFnkIYeNzeQ+eGDhK3vnuTK+eLDu729uhLjvSKE7OX+V7A657gMI4crmfaQXA0nTSIzqL4YRGkLUSZaVO3+4utrGDKGCFy6juQdaqgweYsJ6JlZyyn5paZZssSziD6Sv8ONELAss4NArIcLaxuZaK1zcCHlP3GCATUyJ9mxwk3IsqYKrVS+Wnq1Nc3fjgQ5N5dZtx9U9DRjFPZ77UPzFu6sV2O/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgUSNDMdPhnsdoKn/zWjvSaTRimO85Q+gG/e3sbKMqk=;
 b=o/D8KPhOyZaErO8Ed8WyfB2qxFxZFMTAeBgQ8Tuq5YF//O6Ja8RbW/bsLKq4jSSCejXIGDdKnjpH6UpKQGXw4p++T9qMn3aqE9bKQd5FCeql3KEu149frBqrKe8TvZntzJ02RbBUHe5peYMA76mwQq3CqGIssmgy7LUSvLgNcfmiybENvcrrQ6v7qW4Q+n4BOiIZBKuOU/utBTAKcAeq/4Oqq8qdCNl+Z+4fbpEiOGnrC/0RSGzc05HQJGOQG3Bs8zoif5XrwBshvmEl1jwv7bfNPDx2SH2b+QCShbNBX6qfm6k5ZnLnS5WiCd3GT0ZIxyj7fLe7WA5Qa4U5isSlSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgUSNDMdPhnsdoKn/zWjvSaTRimO85Q+gG/e3sbKMqk=;
 b=haUhhkMm/Q9fDCOmhNUWxvNR27MgjNiizj7hbQ0yTBuso654+ldUKiYBlkMsqXseQ9HfpLIbicl5NKFcHQmzPvsYm9kIJYUj60ILap/r3yljKlwuuC81qwlzy5Fdoo8ZOy4zE49AjlmqQr3E+UMFVcGcFnwrHRkKX5soTAn2BVET4oclZJTffBTwXC3cFyLdUPxHqB65Ja++xm8nPxqiB7Cwe+WSfQYYa6wMvGJq//S0NcmVrwQ21SIiABRyMrmHtLkfZaQs0LD2ZG8Ji1g6jC53Blf7vnuAjh2nc4hyk/vtGavfMEkY/fHnz2GmDhh2ISvThfUxxeSNp7Ln7UTr/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PAXPR04MB8960.eurprd04.prod.outlook.com (2603:10a6:102:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 15:06:02 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 15:06:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 0/3] usb: dwc3: add layerscape platform driver use
 flatten dwc3 core
Date: Fri, 26 Sep 2025 11:05:47 -0400
Message-Id: <20250926-ls_dma_coherence-v3-0-602b1c0ce6b4@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMur1mgC/32NwQ6CMBAFf4X0bE3ZYhFP/ocxhG4XaaItaU2DI
 fy7hQsX43FeMvNmFilYiuxSzCxQstF6l0EeCoZD5x7ErcnMQMBJKAH8GVvz6lr0AwVySBwlglZ
 93RgNLGtjoN5OW/J2zzzY+Pbhsz2kcl3/xFLJBUdVV+fKqE6r6uqm8Yj+xdZUgl1vQP7QYdVJl
 rWSjdJG7/qyLF+2/CPb7QAAAA==
X-Change-ID: 20250602-ls_dma_coherence-c3c2b6f79db2
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 bjorn.andersson@oss.qualcomm.com, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Ze Huang <huang.ze@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758899159; l=3299;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=p8ByMieyHd8xhybHZuwhL62HeyTNBY85lOMLDA60/z8=;
 b=QdGcwwz7QV2td925fzahtS5Z3hsNYWXt8VzBJlGl+RE2GQ/CRBGaK/GYZo2iy80pvK6vLQgH1
 uhaBoVoXWKEAtYechyDtFl9hQtdIto13k21d2gxPE5BDuBcskj++cKb
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0072.namprd05.prod.outlook.com
 (2603:10b6:a03:74::49) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PAXPR04MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aab82fc-f7c0-42e4-4078-08ddfd0e3577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|7416014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2JHOVlOcW94UGxON2lvenlzZzhGOTI3bWNkdDRvSWRkVjh0NVdQcWEwd2dC?=
 =?utf-8?B?QjFpeTF0UDVIRjM4TjRqWWV0c3d0M3RjVVhIZFRjeng3WDJ4YXo3ZHZDRW9S?=
 =?utf-8?B?M2REei9PUDl4NjZNVjlpWkoxRkxTY0l4dmVLMXpCT0FidmowaHkydTczZFd4?=
 =?utf-8?B?dHZIaGRvUnhvVUE0dzFZL2dNT1Y1T2drRjNBMmE3SFUyRkpwYlhndVNOSVYx?=
 =?utf-8?B?dUJmTlNNWjAvT2F3a09YdUFvZXF1ZjhyT3JUU29ucXVqTEtIUmJtS2tFc1BU?=
 =?utf-8?B?b2NTWXh3dVBzRjRiQjhmSWQ2LyttRGprVTZ1eVAvV0RxdmQrWjBBOHBudXk5?=
 =?utf-8?B?SXhiejd1K082R3FUdDI1OEF6NWJET3VjUTczdGlGV3llMW42VFZha29CQU9K?=
 =?utf-8?B?L2tUZXZsUzhEWXFBUi8vdmNhZ3VLa0p6REQ4cDhwUU10WXoxNXVyZTd4bkJ1?=
 =?utf-8?B?ZEtFdjdkNlpWRXVnb2lIaTNCMGVkNXoza2xGWU96WXJEcjE4eXRYcG5BSFBE?=
 =?utf-8?B?c2ViMzBsN2hGWjJnUEw3dmU4M2gxVHRKYndwZFB1RzBScGttcnZHSUhRdXpD?=
 =?utf-8?B?bUsyMGtQTVdybUpITGZoQUI3d3Q2MzBWWUlzSWVQWGMrSi9NQmp4VmdVN0ZQ?=
 =?utf-8?B?NDRQRzNDbXhLcWt1d2dyVUs0RVBFOGNNR2duRjRlUE9wUTVEUlk3c0Jyc2xN?=
 =?utf-8?B?MHM3VzVybi9mUXFvUzJWeGZDdk50a3F2VVREOWRXL3drYVFSdlFHMVNMOHYv?=
 =?utf-8?B?VXNoT1BjSmNYTHYvdURxamU1ajVzV3pkOGtQazE0YUMrcUtHUDUzYzh1aU8w?=
 =?utf-8?B?djRuS1F1dDM1WkU0aDJhR2ZDSGJwbndVOEUyV3lnZlN0R0NVakxGOXdLZUds?=
 =?utf-8?B?N0dkV096UG9ycjd5RHN0RElFdXFHM0Q2MXNQMktMLzh5ZzlMUlJxeWlYN0I1?=
 =?utf-8?B?NXRmd0VLcXRkdlo4OVhsbVRWd1VJanZPRXhxeUlwV1pPYVYyNUY3QTJhZ2Vo?=
 =?utf-8?B?bG9nTE5HNERWRlpTUDh3N1liWTZLK2prMnF5ZFErWW5Hemh3Q3BadlNsS1pC?=
 =?utf-8?B?aWY2WG5LQ2pqK3FVQkZGS2xqUlRGQ1dEdVZ1ZzM3WmZmWEw3RzNhaysxcHVi?=
 =?utf-8?B?ZkNkZGtXblRUN24vWG1BdGFCZTBYZ1hIaW92MzNBMWRnWm9JaWVaSWl5bWQz?=
 =?utf-8?B?ckNkZW9xQStSMW5DUUpCZStjcEptUWZPYXk3Y01Zb1dNaHZOc0dzR1JwZnZh?=
 =?utf-8?B?OXltUmRMRzBpYUFKYVRXQWhNcEhWMmR0M2YvWkVHMFZjSmFvbExkMm1vWHJI?=
 =?utf-8?B?bWpJbFlEaWVoUld0SDF6Q0ZNRGlzREFQSmEwQjVJQUVQMzBRZ2pEU1VlQnpI?=
 =?utf-8?B?aUg2K050cFY4SGFVM0YxOWVWOUc0MFlRaWs4VDlkdnNHc2NWMkduQ2ZldXBx?=
 =?utf-8?B?eTYrWXJPT3BVQnNxQW0rWGx1UEFkSTFyTFRoOWkvMk8yRytxQUNjM0o1QjhJ?=
 =?utf-8?B?TUlic3k1U0xsQkZCOStVM3hvQWJJSU1ackNSTnNmbnd3cEh2NzV0akltbWNy?=
 =?utf-8?B?MkMyWXozT2hzWlk5NnZPTk50dklDdFl5Q1lLb29tNnlNbkplbllUV2pxckdq?=
 =?utf-8?B?bG1WY3JDRVE0aXBhdzM4VXJiaWFERlA4T1Mwc0RPQU1URDZ2b3ZXUURHd1Fo?=
 =?utf-8?B?aDJZTjVXV1hhNStnVGlhc0tsRlplT3lxSHFSck5XaExHY3lRYVBGS1pFc3Vq?=
 =?utf-8?B?TzJQeHYzSElISjVITEx5bjFGYWIzUGMvS29Ed21SeGdnaUREdm5xQVJEOURo?=
 =?utf-8?B?c3BNZXJJR2ZEUHJTWUJxR2VCaS9aY3VHdUY1cnZYN1o0QlgrcktPcXlya1pV?=
 =?utf-8?B?a0lFNUgwYkUvRFkwbS9uaHFHWnlIV0d1SExLcGhMa0tUa1FZbTJHZVBwalVx?=
 =?utf-8?B?NVAyUm4zTW5QLzhTLytVNUpWWHV4T0UxZENtbkZZU1htRm9lRW5HRlpKcW9R?=
 =?utf-8?B?am1JY2VlTFVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(7416014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFdsSEt4eTlMNkxpY2NYY3dRUG9oaklwd1gyWDd1dGU5TzVuVFhiS09xT0dQ?=
 =?utf-8?B?enFyVzFJVTlGZlhOV3lKUGFTMzB4bElKUlZSYk9BZk9uc043YWNjUWhsTWFY?=
 =?utf-8?B?RUZTQWNKZVV3YkxuL21LMmphYllURWtrdUNpVEJ2YWltZFU1M2JCaDI4MzNW?=
 =?utf-8?B?N245amQ3dWJ0a1l0TFMzK3NjRVZkQytpS2JxVEprVXhSUmtWdjJVM3RRYktl?=
 =?utf-8?B?L0ppVUJjbEcrNFFNWWJ3Vi8rOE1qS3NSbzZFU1RvNGZiSXdqTi9rY1VmcVkr?=
 =?utf-8?B?MzJQSVpHaVRYN3dXNE9rVlpONUlVSDhQMllGMFB6R1FvVTJVOER3bmxLczg3?=
 =?utf-8?B?QjN2N1lwZ1NvVStISXFyMzZTNzNST3IxdnlGNUY4SnhwSmJzY1VDNitaQU40?=
 =?utf-8?B?RGxsZjc0bXhJOURmWXVlTzJTbGdWYWtQWG5VOGN6bW5qLzk3aDdzWDJUaDJs?=
 =?utf-8?B?dlB1N0JjWE84N2NnZ1pNMm9sd0dRT241NnhTSUE1ZmFobVJzejdaSkJKdlJL?=
 =?utf-8?B?TzJObmR6d0thOXBYS2JnTUVZc2hDZHlqdUoybTJtcUc1R0FITU1wbWJqV0R1?=
 =?utf-8?B?bjlZazJ5V2lEZC9rZnVTUW9tSTJSQmd3TG9VSEkzQ0dtaVk1dFhrcW8wYTVO?=
 =?utf-8?B?SDE5cUxRK2VOczQwWVNYZVBlTUdVUU5ZcGlZdU1pYkNrQ1k4SVg1NTFQd2Ry?=
 =?utf-8?B?d0pDTDJmRTZDdnlFOUVIc0w0VUFmdmd2Z1pmdFVjU2RaM25VNDhpL1ZJOVJz?=
 =?utf-8?B?TFJ1bnZ6YUdEL1RIWXZCaEhwbXRIMTZwZjBrTVJrRlhvK3IxcGljZHJVOCtx?=
 =?utf-8?B?dVhrb1BzMFREV0dnVm1GKzZsR1pJbmVCYlpwcGFmaVI3NGUzSkRqQ0pNdm1r?=
 =?utf-8?B?T2lrS1JpcjY3MTl6dzJnYUR2M2Z3Y25RZFNMK0xVNVdhbE11WlB0WkZiZTJL?=
 =?utf-8?B?REthanZJMWpXYUNKTVkwVTl6Uzh0ZS9lMkNXbGhxVEVBSWhyMU94TmhGZjJ0?=
 =?utf-8?B?M1lxbWJsZXdpZ25EM0pyaEtieml5OUhlaFIxUTRsaXd4WmlON0Z3ZjhDRFdx?=
 =?utf-8?B?dkxzMEtsc1ZCOVB4VnE3ZDJLWUtHOUdJSTVjOWpEYlBDZXFhQkZPRXRpWm43?=
 =?utf-8?B?dFRZQXdUMlZieG9CUXcreFFrUUxONGZYNFRvZ2tnbkk3SGxYYWhINnRBcDNT?=
 =?utf-8?B?TUhkQnRYWktXYU96OGxHaXdWTHpSL1Q2MFR3dTl0NHBMT1ZJLzRoYVY0R0I0?=
 =?utf-8?B?ZmVaM2tZQ01xK1A0RnlvUGJVZVNaK1ZxdDVQa0xvdHhaTTNyNEttSkhGYU5C?=
 =?utf-8?B?R2tjdHh6eHhNenFOVXdUUFVUbTFqL0UwaEFlRTNZRnY5Z3hpMEVwN0IweE5q?=
 =?utf-8?B?Y0QvNkVpMkJkakQ2L1VRK0V2Q3FjbnloUTE1eE8yUWVzc21yYUg0U1VVbGpZ?=
 =?utf-8?B?ZHpVeUJXTzgvNE1nZHZwaTJXQ2FqQkoxUGM2YnduSjVydENxdDFHMkJJZlFn?=
 =?utf-8?B?UkdDanpFeC90NFNYVkZPRW9OOXQ4dzVxekR0TFhDQmZaQmxSWU43TkJER2lG?=
 =?utf-8?B?WHVHMDZ3ZFhaeVdJaFZqRm1GV3BWd0x4R3NsdXhzVmVoS3JkeENTblVsajI3?=
 =?utf-8?B?dGRibXZEME4ybklja2x3SVR6K1F5Um0yYXN0MXYwc2QydmRvOCtCaGFubGJX?=
 =?utf-8?B?T1psUXRrRHlqR2Fnb3hrVkVqWmNUbUFhd2Z5VHBoWG1HNTRQdm5Wd3Fmdm9u?=
 =?utf-8?B?QklKeFZxT0NsWTVHdjBEWGVzYnZqdlkrOE1MUTVucy9VZVlqMVRGUm5yQjNW?=
 =?utf-8?B?T3VtT0JvTUxLd2orUnA5U0JLblJxNzQ1SWlIbU9ER0pjcFNlWXl4T1dHVE5v?=
 =?utf-8?B?NFFjSTVmNDVWanpNZ3c2NVBlYzRueW8rby9FRzBLaW9TekMwVHBhaHNLamVC?=
 =?utf-8?B?RG13M0FTRnBrdGNWbTFCSEp2Nms2MFBDcUJINDV6d1l1dndDL3lUbW5xTzRu?=
 =?utf-8?B?c1R0OGZSZWRmS1JlbnQzejE1TkRXZWZNM003aWJoWHdieW9qTWFWS2IvTVJw?=
 =?utf-8?B?OG5GMEkrdWN1disxZFozeWFmY3VEa1hhQnU5VW9CblZUcUpFYzJaUWhKbzRM?=
 =?utf-8?Q?5+jSpWIzpHkwxaPZt0TlOa0d5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aab82fc-f7c0-42e4-4078-08ddfd0e3577
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 15:06:02.6242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PunWlqydNpDQVo0DA6TvyFnMz6CRetNFAjo0kT43XCR9pjW4ktGR7R3GyIwOnn21yex+ZJnDq3cFbpBSPcT/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8960

Add layerscape platform driver use flatten dwc3 core to enable dma-coherence.
It needs set gsburstcfg0 to 0x2222.

There are some several try before:
[1] https://lore.kernel.org/imx/20240710-ls-dwc-v1-0-62f8cbed31d7@nxp.com/
[2] https://lore.kernel.org/imx/20240123170206.3702413-1-Frank.Li@nxp.com/

[2]: add new property, which was reject because there are no varience in
the soc. Fortunately the below commit resolve this problem by use software
managed property.

d504bfa6cfd1a usb: dwc3: enable CCI support for AMD-xilinx DWC3 controller

[1] was reject because there are not actually dwc wrap at layerscape
platform. Fortunately Bjorn Andersson's below patch to make it possible
by use correct dts dwc3 node layer out.

613a2e655d4dc usb: dwc3: core: Expose core driver as library

This resolve problem [1] and [2] by use flatten dwc3 core library.

1. add soc specific compatible string at dt-binding.
2. create platform driver for layerscape chips and pass down gsbuscfg0 if
dma-coherence enabled.
3. update layerscape dts files.

To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: bjorn.andersson@oss.qualcomm.com
Cc: imx@lists.linux.dev

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v3:
- rename gsbuscfg0 to gsbuscfg0_reqinfo
- Link to v2: https://lore.kernel.org/r/20250923-ls_dma_coherence-v2-0-ce3176396bdb@nxp.com

Changes in v2:
- base on drivers/usb/dwc3/dwc3-generic-plat.c

commit e0b6dc00c701e600e655417aab1e100b73de821a
Author: Ze Huang <huang.ze@linux.dev>
Date:   Sat Sep 13 00:53:48 2025 +0800

    usb: dwc3: add generic driver to support flattened

    To support flattened dwc3 dt model and drop the glue layer, introduce the
    `dwc3-generic` driver. This enables direct binding of the DWC3 core driver
    and offers an alternative to the existing glue driver `dwc3-of-simple`.

- Link to v1: https://lore.kernel.org/r/20250602-ls_dma_coherence-v1-0-c67484d6ab64@nxp.com

---
Frank Li (3):
      dt-bindings: usb: add missed compatible string for arm64 layerscape
      usb: dwc3: dwc3-generic-plat: add layerscape dwc3 support
      arm64: dts: layerscape: add dma-coherent for usb node

 .../devicetree/bindings/usb/fsl,ls1028a.yaml       | 33 ++++++++++++----------
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |  3 +-
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi     |  8 ++++--
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  9 ++++--
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |  9 ++++--
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     |  8 ++++--
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |  8 ++++--
 drivers/usb/dwc3/dwc3-generic-plat.c               | 33 +++++++++++++++++++++-
 8 files changed, 82 insertions(+), 29 deletions(-)
---
base-commit: c45d2c21b3889c520bf141d576eaecb25666895c
change-id: 20250602-ls_dma_coherence-c3c2b6f79db2

Best regards,
--
Frank Li <Frank.Li@nxp.com>


