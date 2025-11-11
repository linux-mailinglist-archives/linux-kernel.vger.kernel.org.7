Return-Path: <linux-kernel+bounces-894706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B18DC4BA88
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC5118918E7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275732D3720;
	Tue, 11 Nov 2025 06:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="WM7JiUuz"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C3F2D6407;
	Tue, 11 Nov 2025 06:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762842077; cv=fail; b=naGuCLsvKOjvbcWTspWotwIUUGuibpmBycCFHr4zWvTm10QhAUmajoDYCrioX59czaecOwevxfqUDIAhYyuai9PPbU5YEX3IY6lq3boesHLL2h5MbA0vRskPFw5xjVPoUgra0NS9znbXyAgVwOp/RQ94ry4qzcdeQxKjThn5XMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762842077; c=relaxed/simple;
	bh=e/pMT98R65aYpmdGQ4NijMpL1vlQZAytFuKLnOAi2PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gh3+9c9H3b6tugxP8DcioB8IOTrx2zhzvf/EOHwZQgjFmhiAHWDjvlUrfC5V6MBhKLYIQsGDt6JnXoCYlSSicgjYqckOKgFFGdEfN7AyNGYmjvRSvOviVSPSUxaUhculQLSq8rK0P3QwZ847blOEdF7pJnSHU1o6h86szaOgY04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=WM7JiUuz; arc=fail smtp.client-ip=52.101.62.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjpiNCL4OdQkVuF7nQHrsChpfLBJXfdJtT2xnMn7myCekjUCqcd2afGxybtaWFI86d+JKQcjz8lH9jbfvTlme40QV4mC0Udvs3kjT5lUJO5Ow9MsQUB0DhkebLdNseHrjt6kLmHP/bpdQqOq54bUYe2dPyyA3jpXcm8Rimjr3mdRZMuZBYd2U3ReCesV4he+iZo2/vj+TsTtGYFOaj78TPlvcKzFYDda0nzv1orRbXnnCDXg8BS8JyFgzLxn4iLy5G+jGBqLSH26IwsTHWGFcl0J/h74ApAJHQ8G1YZXkceEueY2YkclImON3w9SjAKg4p0hn7DZDyPca7JVzOik8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJBCLvN33Y3/gerndcZzix9hzUQw3k6o8nsFrTg0k0o=;
 b=gxkuy/IvMLlGsjSjbPbW4Uk/glQuErHoTf6cYlNG1qG7fdvakTsS4pNWBnkN4Fx+9iT9uy894UmmHJjc4tRuuxbLrZL6bpEKalpyEj5Ny/h5P+pcHL+t3y4RRxdehKlKXHgFoccsb/hyhuHUd/kgy3wmRdYzI45yPzffwWC7M7ymcf15w/DO0nhMSdJ8+M0KsHI5xEY8p04h8OLXwjlwEC6egpyAYeMyXW8njUHUuXm16UejnTAje6KrSF7zfcivO+kSwVsVaMKUaw7V4Iy+WgjE2BeSVQ7LcYWeHwuIFWSJ5KF/5NGf74jTMkDwsMlmEv+ueWpifxQO3dm2kB39Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJBCLvN33Y3/gerndcZzix9hzUQw3k6o8nsFrTg0k0o=;
 b=WM7JiUuzzPIQ8FDZk5FHvWwCJ2vtbCgKgo9OtTZrywjxfb8x7E+2tMqtCxI1rfuaPbyFLm2+yx0R8BkNewfOxcMPxoJ81zrWV8zO0kFxwT18q7uZJq7hhpFtJ+6Cl1d6trNpjJgSC+xamWr/7fFg/LtyQzOlWhKY8OCnqikOgrffzMz7dOUDK+8rL6DVSMJ9T6zQyslts7kaY+79zVOo2HQ1b9qyacaHlcLo2CmUCMDaOIjdGT0tOU0LJBMcVK9SrKRr4W0TNZoIJv2DhJ3o5nB55NqO0Af3rJ20y5jsUjuczmaEmSmaaF9pk7z9VQK6jpR5mX+AzC6b9cy+aPBAPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 DM6PR03MB5049.namprd03.prod.outlook.com (2603:10b6:5:1ee::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Tue, 11 Nov 2025 06:21:14 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 06:21:14 +0000
From: adrianhoyin.ng@altera.com
To: gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	Thinh.Nguyen@synopsys.com,
	devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: adrianhoyin.ng@altera.com
Subject: [PATCH 3/4] usb: dwc3: of-simple: Add support for Agilex5 SoCFPGA
Date: Tue, 11 Nov 2025 14:18:47 +0800
Message-ID: <6281ebd197c36d7bf7fcd3b2b5781ffda22e0f93.1762839776.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1762839776.git.adrianhoyin.ng@altera.com>
References: <cover.1762839776.git.adrianhoyin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:26::14) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|DM6PR03MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: a95853a7-474a-417b-27da-08de20ea83d0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xHK/PSkr/jJ+QWSrTqxd6F1EjsSyJWd5qzLdvjrK7wK2FlhoRlFRtsLz51oA?=
 =?us-ascii?Q?B+01WAf3TG2KXRcEo+PpjJxte0oCHs0v/QfenAmzI+FG5A6C9Ma1Ng52ubqd?=
 =?us-ascii?Q?PAuYhk5I2/8+c3dimfDN/WGFtKX0W8gyzuEe6QfF9/nXgs18LomtK07gn0GP?=
 =?us-ascii?Q?WH7IhfH9sZbiZUAfYCC4Hv4O6/9fioC1IWhlr8lyG6GTSxH1WYwXSmWzFYNc?=
 =?us-ascii?Q?+P4oefDWpsKC7ElHt659oUxBoirxQ+BntzWeu1TrdwStTRvt60v6Jkftzwo5?=
 =?us-ascii?Q?IJdyTbwoDzXkOuuQA/T3nR2XYIrpyffDnarc+0hRLnEL4XH99J9UX35BJdHR?=
 =?us-ascii?Q?CN0pPmJ4DdBcTb+Biz2ncOOA6QrMnS6PZfQIbeLba9Hmr9ovQRVWI/FoWsot?=
 =?us-ascii?Q?PN9yvQZdBj+eS6/5anOq5XVeO/IXdCxgofezw5i9AY9RP0DdIdh+KfpQLY3O?=
 =?us-ascii?Q?3tEIfYRngQ4HY0bbVtsJzk5BHcmjw3P9VLaoYfP2F7NSkxts2M1enAvEbLHB?=
 =?us-ascii?Q?nvx4eE77AkT0nMcil+QJ1kXhn9pqPDsbc5j6qBnsGrz3oJxwvqnyhdFqiMjI?=
 =?us-ascii?Q?rrRpQ/IDhI9KpvrTU5tCa0c++O5w9p8PTA20+SzkPhN45pPBEb3RMYmjkI8+?=
 =?us-ascii?Q?104YcjQyqiVvBE1pPlEg6/OefsvMOZ7sJEnLGrTgukWaj9oF05jFekIGhjK/?=
 =?us-ascii?Q?DRkVuKNIBJaE7P0HeQOr4KD3Pn1JjwgMP/5/48DpXMwQQopGJ5w2xn9b41O0?=
 =?us-ascii?Q?HVTs7h0EL+KhyENNpY7TXTEYOqlEkuylwnHncpIK/YE41B2Dn36NyuqfRktr?=
 =?us-ascii?Q?P7Jo5xO6coPQjMX/RuHoGC6bXoy3xx6Kt6lAhXxiaeRmHmGoGQFomfepf8Yw?=
 =?us-ascii?Q?7PnGBbhAU7vdRIWhvt8iwsQkF04Mw9Ky8J1ZP2/yG93Fthtm7js7fshYeVkx?=
 =?us-ascii?Q?dK2rUH1a/vLYcY/WfID0K3SypdtabZNLgGKxil5DYgm/tKX+DU3JdAh73MKb?=
 =?us-ascii?Q?1tb4zAZlLbxWqvsDoo+4zk/jyEUQdTxyuEoR4Y9DYk6OBoHiitZDfi7sR/Ob?=
 =?us-ascii?Q?r9/6wun+sQLn3WTYHmxlkeArCHBQLgdSoqbuvbs5+ex8yJgE4wEA61zR6y6g?=
 =?us-ascii?Q?yx0ZHrX3T0Q/wYKIkcCdGRiJO92YqXvAQqjhzwhMv7uYDjFTn4ltmHY7ngFM?=
 =?us-ascii?Q?UCYFZDuvaMj9KNtW/9Mt8tFW8uq6dC56wquW+U4WmblnQTruW9+mt8uLr8fg?=
 =?us-ascii?Q?f/CiZINvm/jYrnnmCSF9PRVLBz5kOkGSX9UD1Ohps01r31GnPRAx76vSFLnI?=
 =?us-ascii?Q?ketvbWcwuaMz+nxYi99Hqs5bIjKklsYbFpns9lIXJLfrmAOeQKT9L1ymWowb?=
 =?us-ascii?Q?gYf/Uh66xFq5/PYzeJyDEWMUGEhnIJFbFEptefNz2nx3grNyGMZEaXImDjzT?=
 =?us-ascii?Q?mf7/eG8nykSXzDyXSpHnTtebLzVYF7Pg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AtWaMPKEI181hFmwTPQRfvriCIp7JjjSDtpwcCvKJuhnnddyAYv0PYHMNarU?=
 =?us-ascii?Q?HUKhBa5hBKaQ2MSTv17sOdcnQTxMjyC5ZnmZ1mxnI8ihTNN2iNb27IA/Y/i9?=
 =?us-ascii?Q?O0LQECrIzJrJlPmsW0z52IXQTKVaDLKT2JdHhiCbxmQWSWEHSMsMHXFcODep?=
 =?us-ascii?Q?mEYt8DX5X7TGSOqrkcOnChZZEO5CaX/hy7cpLC2W1CI4duBhEZauaW+cVFxr?=
 =?us-ascii?Q?BbqevJCjJp/ReUE/EUdDoX3mNeQJ8oJSmeY6TsmqWC2L80kdRZXDEzc6lovQ?=
 =?us-ascii?Q?dHmSb2c+ERgTA9BQugs//KCW+utBCa/w4CVmwg/Bc02Xb6RVB831sD/7fv9k?=
 =?us-ascii?Q?g862zQOauV+rvBsUMtS1mDJginQp4RckknOLnqdYA++I2aJAc4iapqS/eWET?=
 =?us-ascii?Q?zhjrqVwm361eIzUqFeOFMWq1McfWHHpWA5kPUw0NnFiQtyya1aLUKWk86Egw?=
 =?us-ascii?Q?6Dc46XODt9JzgPo6/EaBytQSWpleVFYI7br3+KXTq0C796OD0y8rZnaP6b/h?=
 =?us-ascii?Q?yg3HhJhscNwDPI5mkS1gpuk+orbjNFNQzJ/vTRzJaV+0Idgkjiq4HUXp4E9v?=
 =?us-ascii?Q?NCHfZiphW+1fP2zhKGUaabZ1Nxz1IHL9/0U5vv1w2GJdVmITPK0J1g5bcAl3?=
 =?us-ascii?Q?Se5skBka4F5pCNTO0lt94g9FGXZ0xJk8AdnuTRolejjlfwWSnckgPiZA/4YI?=
 =?us-ascii?Q?1CZA73L+cIyAKPfT2RnrQNWn0F6oDXey5e9yb+nd/sl5NBkorIHXCblLxbwo?=
 =?us-ascii?Q?kB7grUHFTv4REx9ESu06go8k3WSg3RverAkp2gaSqu1UjaQNvNl+aAPnQzh6?=
 =?us-ascii?Q?4BmYXCl/ih0wVPJlKLSwjRTKbRjDE5eV9t5mZnAJkAqXGgZI4vPLhqNFKuvW?=
 =?us-ascii?Q?YrjWeG9ifNP6fhQj9WOCOmLD3cp75FFfPY5zjtjfvrScFYMAjw88tRq5pQnZ?=
 =?us-ascii?Q?sZBuoUXFb6LNBgumLt3JTNBjTNJGaEUnaFJQvnoyJZSrGhZXBQPM178J5a7x?=
 =?us-ascii?Q?+FlivxCfhnJ4HyjAq4B0tjxOWHXcirg608hyoudW88CDOX19qQUOcBEjKbWv?=
 =?us-ascii?Q?2tSi+kKDViFaMAscVmQSy4U7a8zUn1xXYkg2k3dHNqs5IHDn4enT7kK3DZ7g?=
 =?us-ascii?Q?jucRrBpATLJBESyORwSidVyi9ZF97Yfm/MbjDcFy/XVfBlU+pGx7iX8nXfqg?=
 =?us-ascii?Q?T10vc1XltZ78SKWzRTLiKXAVOKWKtBdojahitONS7tmvjdSkYilomuddVdxQ?=
 =?us-ascii?Q?Uth8StYY8UTHo5osKJVg4SjGRcgikcBwfOXAIzvrdIpjQYO5DJYbgXqiuDCJ?=
 =?us-ascii?Q?ROYQ6cAwuo7rm4nQchNLtZZBS1sDWoiX2GCakIKXgbLGartZapUWcI3PBn+5?=
 =?us-ascii?Q?ZhDHCRHCBfzMxWxm6723vni34tKts6Aa/muXv+s6aGOsp/fxNq+H4a97o6w2?=
 =?us-ascii?Q?16SRcD830EXK8qRkmmXaNlCe1GkAFILZYjpKrA8Ubow+0qtnUqgjmfOl04sA?=
 =?us-ascii?Q?IxtklgduOx8juR/s2mk5UklW+/e3XbeNSOSBLpbF7HgbA50pQL50Mu9Ax22o?=
 =?us-ascii?Q?D90w887GEIEBCRRAHBlOMJcRRoCT6rB3xYsEtSQBI7uHOoej0sWcjQS121c8?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a95853a7-474a-417b-27da-08de20ea83d0
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 06:21:14.2221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1slLLTk7CV5//E1NgHB5cZUXDwAfNBzJjwjzQqk72iXRdkOw6POiN8AcYeBLJoUTE7gcijnLiavp26XmM9A4HMHuxn3E2AJULzYgy2NtYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5049

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Add the compatible string "altr,agilex5-dwc3" to the
dwc3-of-simple driver match table to enable support for the DWC3
controller on Agilex5 SoCFPGA platform.

The DWC3 controller on Agilex5 is instantiated as a child node
under the DWC3 simple glue layer. The simple glue layer is sufficient
for Agilex5 as no platform-specific initialization or custom control
logic is required.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
---
 drivers/usb/dwc3/dwc3-of-simple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index a4954a21be93..52f9ee236a1e 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -174,6 +174,7 @@ static const struct of_device_id of_dwc3_simple_match[] = {
 	{ .compatible = "hisilicon,hi3670-dwc3" },
 	{ .compatible = "hisilicon,hi3798mv200-dwc3" },
 	{ .compatible = "intel,keembay-dwc3" },
+	{ .compatible = "altr,agilex5-dwc3" },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_dwc3_simple_match);
-- 
2.49.GIT


