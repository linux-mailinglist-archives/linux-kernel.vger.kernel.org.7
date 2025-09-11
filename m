Return-Path: <linux-kernel+bounces-811248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2136B52668
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 04:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D88617FDB9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 02:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF03C212555;
	Thu, 11 Sep 2025 02:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="HUIwceFO"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010056.outbound.protection.outlook.com [52.101.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8A7433B3;
	Thu, 11 Sep 2025 02:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757557284; cv=fail; b=NLcUo1d6IWVeH/4yFdcXXutuVwepf3Nyef4FDbMBKy2JKJMsgDRxe2Eklvibb3GnDWoe1eBYZHetgcbUwK3GLnoF9fZ3jRYZuUXRtQQL8/ePduvKY9+xXLkQ9xZv7E+x7WV/4RMOpb1XT17oI4kbOtcfW5LChIz3ZXlD/wAKrwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757557284; c=relaxed/simple;
	bh=fmX/ZgPxvHJXMS59htUOqTY6CR2vwfU7scRI1KZCEuU=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FTVESSHKnhx1e+tKPvtrs8xL4ZHxJca6eHNArkF3sDKbjktDZJdUAOQrJ5aUqr6TVEjKPw2QH3b5uVqJvlSM9K4gg5gMYLqH3z5kPAv4OKmdAT7Buw5Jrx5RHYhiF9L1zhcD6gPfkMhu3TpIRD3sb0ekqNbf5EiubyhkfWOKqh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=HUIwceFO; arc=fail smtp.client-ip=52.101.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1iqO9jGJdLbRU8J3alHuDpJAATS64f1D+viTwoOnze/ykiHfvWiJxDPlYYrnMFaDVxN2Q4QNktlblRbyFQHzZal+3xnahm/0ozqa4iRVPyDWtrbC22ZeUO9CeaCGxSRZypU2iWMbVoazF//5l59xtnsIlERaBz8iHi/VF/BYiKYt5s6Ry7vi9uNxzdJgAx4P3fosPyKSC9TkBQsMfSkjaB3TSQC/C6dP010EGUBpnLqyInFo2hxeqvhdmuK5LwU7763BuCI5kzt/qjhxWc1bmrYDZamqKQH93DH5+Tsww+HMquxxqetAGUWELG4kj7jM6KZ7yePdzVKeyyY7pwfOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y889/UOvEoPpCWJskbYrwRKPrYJaoGXM8/B/QcfLIRI=;
 b=nUQd2ylEbhZ91ULjDEEuEqGSwQWUC+11J9vvIMHyejKhCehNqRvA406TnN3fTzncBmctN+qw5mP92/TXvbgUYzG1g6GgWe7phecDgoiediwstuI80U7uYgTJtcsQ09ywK7Hpw4h6dESgbqKCdgPYkEujzj8XExbZRP8yJ3BuPcKy/O4lbROSliqcaziFhM4kdrrN0cSrSmFYhzBMuaef9XqD76APDzca+A9pVp/TncgVU9nOCdpMsnfKLX1JZ1IPi3YxUhKUfRmfPnMKmD9jPp52j331iDecURzr1AVRDToAVIE9rfhzP/EASX18/ZLWBPCZM2a+9PYti4aMjNUSLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y889/UOvEoPpCWJskbYrwRKPrYJaoGXM8/B/QcfLIRI=;
 b=HUIwceFOT9S4xju/AMiS51h527+GMMStjgn1xFO6rqIsaFZCBnStzut7BtWI77KrXehiPVMmJtHuzt4jTyEs8Ot5mI207LPNSmcWxyIXwy0tlsl+T8cLix0OBhHNzeIXH4Yc9bOJ51JzfvxfvCBWTg5ErGdlwKUrCnaNrO4dhP7WtsnIlrSv8ZH4Ix5Y8gId6qhM9jvRbaeQy7kQGQgV0JWUPlV23mO+5nL8+UExkMER8+4XBGtdAZEQNJcCHDQKXdturD6rmaaMpmycb3Ac2UptJQUTJNdQgHeQ8St5R4rjArf6E3nqhqIb+VAeE20tvsQ42RQJRXkw7VgrdRgTlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6088.namprd03.prod.outlook.com (2603:10b6:208:311::22)
 by PH7PR03MB7437.namprd03.prod.outlook.com (2603:10b6:510:2e8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 02:21:21 +0000
Received: from BL1PR03MB6088.namprd03.prod.outlook.com
 ([fe80::76:3ba7:5679:37e8]) by BL1PR03MB6088.namprd03.prod.outlook.com
 ([fe80::76:3ba7:5679:37e8%6]) with mapi id 15.20.9115.015; Thu, 11 Sep 2025
 02:21:20 +0000
From: "Fong, Yan Kei" <yan.kei.fong@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v3 0/4] Add 4-bit SPI bus width on target devices
Date: Thu, 11 Sep 2025 10:21:14 +0800
Message-Id: <cover.1756881243.git.yan.kei.fong@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:a03:255::16) To BL1PR03MB6088.namprd03.prod.outlook.com
 (2603:10b6:208:311::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6088:EE_|PH7PR03MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: 43fc5c53-a858-458a-b0d1-08ddf0d9e51f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1UHK+Q+MzXI5YhFlwTye8uqKha+4qXAgUu28Z0w6caKQTcn4Xjb2OgxtMkE1?=
 =?us-ascii?Q?MhEUHcdyKtfAMxOhz/+DgL9RE7jTCql1YB2TvW0XKbg7S9Tqkr72wD/vMqFw?=
 =?us-ascii?Q?c6bfb27jePEi6pHEucBXQ2Kcs/BZ9mYL7OugyNhB4orCgpiUZUzNFYx/hd3A?=
 =?us-ascii?Q?MaZN68eHSS4474mtdxM1Bd31a7dVfIKYlAYkY4YLz5JUz6leMQdqrRWYVEJf?=
 =?us-ascii?Q?uYP33XFinRl88YRrMB/dp4NU9o+b8nxFomjQ3tqmSigsUfoRz34x8YoziyIn?=
 =?us-ascii?Q?zuTYqEmG55gVTfRM5Tgo4wh5tUMhB0xcaqqlxhplENO+FgkYY3T8KWvNy9q4?=
 =?us-ascii?Q?1Mg7U6fcLTTPAeeNgC0BBEUhqAjqPit2P92cWdaScZvO7KKuVmheVC/vVMzQ?=
 =?us-ascii?Q?GKnwi6C4jrT/ymC73rRg0AVXded7KLbu8cAFmgFh5GbeH09MDTFXjP9a2x/q?=
 =?us-ascii?Q?03TYgUJuP51pggX2XhlYEzL2FG1GiLHFXMcNaNrPGZFgit53F/qsEtp45CHX?=
 =?us-ascii?Q?biWz+sZbfVPRns7bkBUTxyDjG0ybp3Op22EgC/bWgG5EXetlA0ceGqp5DD7A?=
 =?us-ascii?Q?lQQ5ftU3T+tdQTm02A1BKOefWorUz+cmU5csb0fYuyKU/+NVnlbOzQj7ifN7?=
 =?us-ascii?Q?gJo04oHXrAAPwzONOzhNqMStMzDtEabD8k7CenLKXbtqiT2yveiHntj10RTG?=
 =?us-ascii?Q?pH405sZbhWnPBMK6I16HJDqqG0LL/x6/9lNH8LPrpHqyasNPL+My2urGqJ13?=
 =?us-ascii?Q?o/i80Ko6hP1cbzzD2vAdUUF5H/KysTV552MmTKnBhS8FhbrhEt3b0+C12eUo?=
 =?us-ascii?Q?z31n/PB9Y71Re/iK1RuYIYty4SjyOWkwatzQFAFFBR2kdWXgQsAN0WY5rZnF?=
 =?us-ascii?Q?BR08g6qXtZF08ug5aCLWOqgMyPpRbG5w+i03u+AQHkFkBYD6h0zmRYuFoph2?=
 =?us-ascii?Q?XU1mpjGJalT8b1wLR+ZaLx98hW2NZJEtNkLFxpYLMCstx71xxNZBk7jmsd2Y?=
 =?us-ascii?Q?YjojU4zqx5F2OkOZC+CggGAn8x/37F4pBZnnAtonq33EpxcIeNqG3kITLYg9?=
 =?us-ascii?Q?E5h9sTj/WTmtVu3QjQrTAKbVJXj31fzkNCvcf45aMCNj5ls+jK0Up9aWqXTF?=
 =?us-ascii?Q?JYx1CI8joL2Z4LBhIDYQHmOt91UZRPTTXarOb82D1hI/dE4if8Lo6vXX+0Gq?=
 =?us-ascii?Q?3R1nMjmrWXHybba43hv2y4OXsvKJDqb/RJOblHdjt+YlvoRZQ+BKgzHyL467?=
 =?us-ascii?Q?d+jdOqOWj46HJXOvb1wmXIZiVCNCjf1XO7wwTfwsr0dwtWvPfEEN9DzeYUDk?=
 =?us-ascii?Q?Qa984vakcF4wZS1w/araR9B0pm+8BCVtj0y5E3azrioE0tAPN1t8Eiulj6Uh?=
 =?us-ascii?Q?Az0KrTukwIaO6y6t5+9ATQdQNwBC8jtFuhGnf6z8QRAzb8evLnLUml/HrB2/?=
 =?us-ascii?Q?MJb7WKnli+o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6088.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t/CRAUmURI4anWlFjFBEXCXfdT1vdsCUG3lYGHXJHdsWojHgcaTbeUINNT7E?=
 =?us-ascii?Q?1raoVQueFxA+cfqMRA9mNT48wqk9deNEYnfJ4/F3jGqfCVk4EP51M+6pYP/v?=
 =?us-ascii?Q?jkHyAo7BsX8cBL36BMHYlgn87G0jvwMQnBAU7VAxevlUFrKp9sYt/rpQUn+q?=
 =?us-ascii?Q?r7Wzsem6DpMv16vQilWkjCfG4CVZF2mIDfbG3+YUQJOO30+5KF3QPiC8zcb/?=
 =?us-ascii?Q?Z5LDyoIvzxPcjdIvx67ilfCcLMMfiq4cMjTyZFKeD8o3gYjzr5Xdqt/ZIFwG?=
 =?us-ascii?Q?oOy9rmw7mQF3ENHNKujU4MFsclioYT6F6oLP5Se5wAIzK58x5Ii8a7DGytoz?=
 =?us-ascii?Q?BiuZjhepiILSmC7m1XXmJadAe+vMQ9U5CA7sISMZJwX3ZJeDAjdJERQBF7He?=
 =?us-ascii?Q?1YrRviFmxZPYOgXcn6TlYOwFSnK9qg1wfXWr7ou1TeWdcWmDKXCiKUIH5Jms?=
 =?us-ascii?Q?v2a5SeztZWms7/f/8LJXe8aLiVk9UA49xMW7N2GJvex1hJnq74JC31ThzR66?=
 =?us-ascii?Q?dBN6x6nwMUZgjJ4Z1KZ6iVan13IGKkKpg7car5IZQm4l5+Y+o1Mi0OBePejx?=
 =?us-ascii?Q?dC+KHThoiFuFXvNO1lkL2lEpw7SFCrw++e+iQFUScESFvAAD229p6igmwqZI?=
 =?us-ascii?Q?8ccYfXl71F6lY5kN5rTFQAFPIkLXkEAI3oS45dpCKwRDUFhtaTOBOf+G+AZL?=
 =?us-ascii?Q?UyIcook8o44u/NugKO2q+uoS4UQmNviYgDBbv/icQiPMURVGHirC6R1lT3Jr?=
 =?us-ascii?Q?4ZN5N+T9fXj9E8YDNOTY+aujeIKTzWn9aITLvaiVH+oBnBg7HpCepmNLiW5S?=
 =?us-ascii?Q?KOnnnSBqeneM2SyHx5VB4ngZ0OF+y+6vNMfHYdEIZpMlECK12zeRPRQ/Y1BD?=
 =?us-ascii?Q?qkN6IDoejfkRx/Poqzs4DzfzKlhAKpesT5Ppnpe6uBqbjuzzl0akwh6rdTlT?=
 =?us-ascii?Q?kOjK1IUlsZrOdlk+9xa6x7V7d1N4fV/yUvHN9A4YSbZCBmfjaEvaCtDm4AwF?=
 =?us-ascii?Q?Q3T+v0MhMYGEcQdxKCz1YrrTk3GIAvRl6zsj01HV7m212KcXtiQXDK+WbqwF?=
 =?us-ascii?Q?+RfWt+OjhJZZRLubm2LnBD8vwaTAaCo3k52+pCPHeGKRXp0kDHPwkSHmPOb5?=
 =?us-ascii?Q?f7tHYz1BrtH52dX0Ibm7vucZ2fLEmThurK4HHsD7uekz6wB//naV352OITzy?=
 =?us-ascii?Q?sSmWoZKGsruzR4QYkxBgTKazX+0RfdgriS4wmsLJlnoo6jtcn/6pUAAD35qH?=
 =?us-ascii?Q?dxcTrGqQCvY/fmpOitJE7rLhwFnOfjd+R2GXBVXSRAR0GQCVsnJTI3tXUpyI?=
 =?us-ascii?Q?jjBmAfu4j5hcfQuabSCKHXZadnSEOz2usfDRjQ/xn+fjOrOv6QSQCD0Mc3dO?=
 =?us-ascii?Q?CEAitLoJBfQVNWk0mOaFmF5KlgvCKbnl2fWUyx1CH4ezQYChJIZ/KBILQjGY?=
 =?us-ascii?Q?BndvkF2ixuvee52Rh00DitbmVggavH31EBO3/ElTMnj5i4dL+22dAdJQTmen?=
 =?us-ascii?Q?chbR4p4Yy5blrHsvqEmXb/P3gV9XufS9xJuJ+9hJA7O4r50A5r2zjZDLOiOX?=
 =?us-ascii?Q?kr0nG8wjslNMwgqZDxl3p3lQBAsqgtYZbW8vzTm84piz0sU3v7zCUn6rlcxY?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43fc5c53-a858-458a-b0d1-08ddf0d9e51f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6088.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 02:21:20.1931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwO5FZ2ADgtlCSi5UbqSYwScWPt1/3CT5zdJrYRYlp5wim0xF3sFscZdbln1DbpAkGZ/QqMVpOS9hpvaJr27Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7437

Add SPI bus width properties to correctly describe the hardware on the
following devices:
- Stratix10
- Agilex
- Agilex5
- N5X

Signed-off-by: Fong, Yan Kei <yan.kei.fong@altera.com>
Reviewed-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
changes in v3:
	- remove the unalign email shown in the commit message body
changes in v2:
	- rewrite the commit message body to align with 80 characters.
	- add additional reviewer
---
Fong, Yan Kei (4):
  arm64: dts: socfpga: n5x: Add 4-bit SPI bus width
  arm64: dts: socfpga: stratix10: Add 4-bit SPI bus width
  arm64: dts: socfpga: agilex: Add 4-bit SPI bus width
  arm64: dts: socfpga: agilex5: Add 4-bit SPI bus width

 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 2 ++
 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts    | 2 ++
 arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts     | 2 ++
 arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts        | 2 ++
 4 files changed, 8 insertions(+)

-- 
2.25.1


