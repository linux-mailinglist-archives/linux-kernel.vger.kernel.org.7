Return-Path: <linux-kernel+bounces-833076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0690BA127D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0ED01BC5870
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F18D31B83A;
	Thu, 25 Sep 2025 19:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WMEWmP9u"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010055.outbound.protection.outlook.com [52.101.84.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F2A25A352;
	Thu, 25 Sep 2025 19:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758828161; cv=fail; b=QZcOVr6WzdT7l60uG7qbgNtx3TrygmWD5k0glGr2NMWpp5sQ/Zjb4GdBV1g6UTgFlJuKAR7AOBNkK/VE0LsIx1BIJcC3jo5GR2lDv7M3DqOJeK/qAOwf4Y5SzhLN3604iU33g8/BUhOplKZRvqzBvqTynzG92zGoZagmlq9SHxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758828161; c=relaxed/simple;
	bh=70KSohMAHNcJnVHmSjXdiZX6G9udWcQScUZyJMXxVPM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WXlnazGnQUobmR9o+zmDg6SU0fh49gBLKfS8mX1uqY2zRvRyj7AjOtqQkYh48RTCbhlBCpnoEaeMFp1Eg5lSKL3b1lzj7Tsm+wOIkD+Jz+NFQigS1q9VzuqEF4DOF4tpFUVlgOliP+cX+eempckhqEgDrW0aceFkxfjZz2jsuCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WMEWmP9u; arc=fail smtp.client-ip=52.101.84.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOn1Ufu8ptt7jeTBcwruZqsUdZ+RDC+dJhgj39cBGkJO6LLnCkXNs9hVw8Qz3TaoZucVZD+5T50PVj52+15EwxRR1PhufEvVRX29zDTU+ejZ4xH2iP5eLBF22BcNkwe9yHIYMtXi0FYEXh8JOca994R5qVrPW/diSvtZRicNspHg0j75M9qJDwsCHewcunxW00yhw4EWOAorrXDzZhdNaY4rOVBUFyqQSeC4uSNK0H0QzPX7bd4IEUc2h9f+fsXtPJarodsrx3qusj2WTYf+gmFnqJOUhjeUWwRfEDrlGqBHaGw4myKvDi4v4TOfZJimtqfQzNVwnLFVZaf6vYGtAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heE+9dHYOMr3jVdeAnZx1KXndmvBTfdZmRMEDfaQJU0=;
 b=N9N/gQGgDi8NHq2WxOwcWl8ZE65PSKSvbDx9EsZDTUJ7VP1DSqWhHcmBoB6GEGObceN8NOBMeuDkm0j6FefkAujNhjFRg0V4IcbAsbhIqFM67Cxt0vT8p+uScj9OuHwKVohZhHVqBP8lD2pIl37fG3fBIFK8PCpIjlPNbZZWaocAZTwslTsaD0FWXXxCAHb5PAklrUnrDal4XpRw2XDyxbI4fm2Yk9zr3nJud6CGUQCsBditUgHhhr0ehWCgL9+Ez+HlG9ij780xUxvAsawW3Hcy9hHx4TmU+VGOZOkorXjP7vdZiU5EhKqr1st3jR1gnFKQaug1Gfg92FL9hDz82Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heE+9dHYOMr3jVdeAnZx1KXndmvBTfdZmRMEDfaQJU0=;
 b=WMEWmP9utzJakB1ReiuH1B/nI1szoCJRF1zbU7sBxyN77VyY8i7Khp+lKaNovG9xSyhhiz0lWS3b1yi46svon9ajJ9Vh7dC9MfZ77bKMKvnorEBp1dlWgX5OAgtulBa/KMSzXqzycXymTCcpa/JEK99wVzxatOphtOTymlMniDdXUfJndvdWZsoMApIpu0VK2ChD8OgnMxOy4SlxxF2lBmNc57Kl6lqKaTVXA/pGLXeiMLwXpKIQV+mR3N1Aq4eAJd9Iqn/03st0i49fX6ZZun08DbqoT3pJTa8NhE34VLAJlEwRd+Z0s6aOultEc4v5rJb+tfU11TMzuUZjdjEgnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV1PR04MB10989.eurprd04.prod.outlook.com (2603:10a6:150:200::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 19:22:36 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 19:22:36 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: hwmon: (lm75) allow interrupt for ti,tmp75
Date: Thu, 25 Sep 2025 15:22:19 -0400
Message-Id: <20250925192219.303825-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0082.namprd05.prod.outlook.com
 (2603:10b6:a03:332::27) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV1PR04MB10989:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b7a8a9-e0d3-4871-637d-08ddfc68e229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QSonlgk/zDU9MqHGONTUsqqTebReUdfNTBD06zwV1vZsv7GBzw3htgbBlBmC?=
 =?us-ascii?Q?ncZ0qxkNuQvc6mi6kxjaP+SvXq+dLrA4MYpFAH1hR2o8gKKLvjwIuV8PVP6V?=
 =?us-ascii?Q?gsyM8pH3LMBiU1WMeLDVuNKngI7qqKDwXLD0Onzr4p24VjEMhZToVeLgxH+q?=
 =?us-ascii?Q?kV8l6UCeEVszf2X+ozUrE5wYUiH/TIwo+J2PMbBBVDnL7nnF9V5+hEMiTkA2?=
 =?us-ascii?Q?fStrsNZcm2qbNCdHQzDkQkjkR1k3ZpPYcFzTeAkk+M3e2dIYIodHK5JQfiXI?=
 =?us-ascii?Q?VYVhfs7bJgTH6Gk001DtNcwZMVh8SOJUVqB9yUBtuPNy67t3MHm7Qli7Ixn3?=
 =?us-ascii?Q?ocMC3xyFH1AFInGdlmsQW4QqzzD49QndOguqbBSpUhgdk+sjhDCyUjBWmSPH?=
 =?us-ascii?Q?AFupebpACc6SGGZFlBTO7BflY8xB26atsYgx25ir4tzTEOCFJw4UpeHK9QZ/?=
 =?us-ascii?Q?buPJPhYzoIKOvVIkZ6EO4HY6shAfqQpemxFA/Usb4n95lkzY4aD1DW4BV/r9?=
 =?us-ascii?Q?xD1oOo6g2OgmUcQjXl0T5VMrI95vUkoyGta6rjM/xKEvyQk3gi31jJelv94u?=
 =?us-ascii?Q?0HQAfrfJU4LPO07ennyJRr7jdtL7jYdXZ5rTtQVYZhSeVplNNrXr569EEOua?=
 =?us-ascii?Q?qChZGghSvwg0ts+YzD/hBZUBe3M+GVfUdrD/TacW8IvEj6OMNv96AecxAulG?=
 =?us-ascii?Q?uaMh6b4pIl47x6jahzYImmBlsEcXuDPZ6DKBnsB3Z/ekmNmu2wcJdff2CaqI?=
 =?us-ascii?Q?jWGQq725GBpdCg70jw7boqqv8ihEx8PunyYwBBTMu9lRK4v3ss5TKGmR5gxL?=
 =?us-ascii?Q?U43rw1YNDKzCNyKg84sCWiWlcHugAu22ZNLgxHeTBzyxPkYwBGlGwfHVN5BR?=
 =?us-ascii?Q?Zbh67nwSn2W32mpERBaSrFCfy6fng3lMcdI3A1vToSJRu/WtjDycJtWNthUm?=
 =?us-ascii?Q?8T8kKq79EVlMyXuuHMiK12Mjwk43d6TxRS48PdDE7lZgmDZP5Ga34jATXcxq?=
 =?us-ascii?Q?fOORqiMFjhsAHCzCwMHfwxM3gHywb659L9BRiD3XWB8h9XoS6MlUswixm38P?=
 =?us-ascii?Q?R3obXOEbsiRxPhHHFHzpRshUliy9SRsuTxeBVZaevrmg6g319P521UPBFlzT?=
 =?us-ascii?Q?bawO1fx+mT50AvVoulbvZ0h78JpOKjgq3qQCLZtEjtqZYZlwlKi5HPaxkeoR?=
 =?us-ascii?Q?hhaqIJsX0JviGnOoPA1Y/cO7f3wLHyQv24UITRIq3zwn+UF5EiBicA6ySVGf?=
 =?us-ascii?Q?p04ZNe4PgLsF5fAsq1uxBStbQz6Rk7hCY/iFYEkbnkWDKd5kK2Ff5TdL5g9E?=
 =?us-ascii?Q?KKQBxTNsyXuTUXUIKAR7lP05njw7yCZbAIMV32VvtsePx83Hlvqbo5avEYcm?=
 =?us-ascii?Q?TMoljBMUBYtFCcw2kedAvIABrSSEUU/F16Ym7awy6hxodm3tF2fI5nhy3UJz?=
 =?us-ascii?Q?roc40LMUdTEnBYeQwwZHGslfQh87miHgxwTQoA7s0uokYEJYRKRunw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GSvGtjh/P2jMmXp8vVSpJSCQqmGqFLSnM5n06/MTp4G9yE22dwFDom8rkWeE?=
 =?us-ascii?Q?6ejAbeGdPyhvsoZWBNDPb3hUG3aOCh4SvriUPGGyHY8fwGOAmPe0MnMFe/ov?=
 =?us-ascii?Q?hIOnmtiGrmtH2E47zOOjvRUw92rHxFMYF37UTZJh2ht5kWDMIdImy8TW/RTP?=
 =?us-ascii?Q?qsQEcK5NK7iaGJO+rl3appeHA9L9eFkp/b0YZwDE0bcpf+q5C26KEsH0RA14?=
 =?us-ascii?Q?EwI+csEmk3OjJSJCOSUxEWaj0Qwgf6eGAaComNVIPg76D9azGdmlogRDbnW2?=
 =?us-ascii?Q?s/nnFv63mD4+riy4/1JV3fvCrAdZMIEC9T2xHqhFEg23wTze9foxLv6shhcU?=
 =?us-ascii?Q?JS8Y7h0PF09SEhdProh89wg93SnZdR3icevBmiUP+JatpjDil8AaJbEJEJ6M?=
 =?us-ascii?Q?hppLDMPzMrwVWAO/alwYRAamyYSM+mrnIJR/5h2ZkJfZ4KJUL+6Rn1GCT4Sf?=
 =?us-ascii?Q?LhXxA3xcN3SKgVVcRRNFIuxe3HVpIxaJrcNVj9b18o0e2UGZ45C/iEXcbwhC?=
 =?us-ascii?Q?+1kV2NQXMh0eai2vsRKw8ffoLnq0RJRR9mVULaItxr3swOJPwM2FOCcMYcoj?=
 =?us-ascii?Q?QvLm4kBU+Nh4cLd/HKLQ9Gg25DYkh79hKmW9hAHDIzBqt/BJOqnm2SBzoCq/?=
 =?us-ascii?Q?MsHD1ZTyup5Rnsy6BNwRMX3TJ5gx7dQXcurjHFnlmOFgkXbAXF8VYXUz+yqm?=
 =?us-ascii?Q?FdSQM5g0JPTyGd2uR0cd4NNzvKEw47sWGO3gmE/o/RFmtJw6hJANpoyjxP32?=
 =?us-ascii?Q?Hd/BmrP8SXxFBVOS04iKNhmRt+uOEj+aorsQ1Ikg7GUw9ho+xKtvY0+qmDX+?=
 =?us-ascii?Q?a/fL5hLCbfWK3AyK9pUgVgkwGndQtMnOrMBtZ50tFkr8VWmaFUPcSJ2CL6yQ?=
 =?us-ascii?Q?v1T5B56+TnengOL5XZRfs+5wGvDQG3srZlN5fHWzgKOaPWBw79V930S1lM2T?=
 =?us-ascii?Q?JsR1bPkPZaThC7cvpL5g2sVPhH9TaGRM1tsbb7J0gCtyTfk1mLGUdalzn+AD?=
 =?us-ascii?Q?pYt3uSf9p8YLNG365OW4u+1XFHtstb9TAHpMKEYVKFl3UCYGYqk8OH9R/Vv+?=
 =?us-ascii?Q?8jT8zuNced4aMmbA6b9xEd/oNUTCsmDJ8zIxw8nR5n6JhcCw+5QXRpKP4dDD?=
 =?us-ascii?Q?ppTsIM2ge+j1f/g30bkOOTxodpN2AXOc5EZmQW6UopBnd+20I1KHXY4fif7G?=
 =?us-ascii?Q?Q7ugtIcvz/sjWExPl8vqfln0ryRhkFYnA6vHwlgEUFU1R59mHGsRZIpiILVB?=
 =?us-ascii?Q?BGPThw3tdlIkXfaYJKGjMkarrL1wkNpD6akLvunBXD4vyd5hsi+qzaUmmbXE?=
 =?us-ascii?Q?JWwWnfZm85UUoo/7woU2FqlSkw9RPfX0BUtt/6eYgc8STmmTdYKGlp/EqKqn?=
 =?us-ascii?Q?HktiFbF6D9gAmlPoRzwASd+MINY31kdLkv/7X/YQyCgFCLz2LbnBmvXNyDx1?=
 =?us-ascii?Q?oDzesvUrVcZbkVJE2OBlXuV3i/KbgKCRpcUcR8LRs91e0FLMLv7jd9WHtbmJ?=
 =?us-ascii?Q?qL7sk7yNcywqu4mPxUZBJO9XSlho0Ocg8pvDvVLMMl1vnssGKq98OAAse12c?=
 =?us-ascii?Q?dkaDn2Nh1fd90EmJAXfSfNPOvo9OZoVLLqqYzGsc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b7a8a9-e0d3-4871-637d-08ddfc68e229
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 19:22:36.1712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0SoZimG4We6SlKDvNB1R4HdqkmOq0PInExOsC3/gPB5mSA/Y/JQhVfJcNtROrueGGO2fR7DXYLlp94xMXrNyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10989

Allow interrupt for ti,tmp75 because chip has open drain ALERT signal.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/hwmon/lm75.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentation/devicetree/bindings/hwmon/lm75.yaml
index ecdd09a032e51..0b9fda81e3ec5 100644
--- a/Documentation/devicetree/bindings/hwmon/lm75.yaml
+++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
@@ -70,6 +70,7 @@ allOf:
                 - ti,tmp100
                 - ti,tmp101
                 - ti,tmp112
+                - ti,tmp75
     then:
       properties:
         interrupts: false
-- 
2.34.1


