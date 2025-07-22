Return-Path: <linux-kernel+bounces-740630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF470B0D6FA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C45816AECF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859712DC33B;
	Tue, 22 Jul 2025 10:09:30 +0000 (UTC)
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazon11020107.outbound.protection.outlook.com [52.101.227.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C8923F40A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.227.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178970; cv=fail; b=beNWGXsaq+fK63gklGImGaMPHIhfaIdohrFBnmTCTQa43LcJA1AyqI5vBiYobOwx/axmqp74UougTpRdCbfVglwGPbhZJ1oid+I6+esFkgv4AnL+2IoEFCFsFkz74psE3nlbvTmwcRp8Ktr/8obSzN2W9mkWBplG5TMbFnMbjuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178970; c=relaxed/simple;
	bh=IfT01Dy0MGzxBYJ12Xq6fdqfyTCa8WHekcTS8k1QQAY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rC9yAAsm5kBFqB1q9Ef7LWn1BnCR/MGxj99buUnkAYGceNYvYO16FZZxbVT/O9jOTcDeR5pLX6eJov1bGcFCpodTwLkG5MpZw14KtjfyfX2lQ01HGoeRqhNJUsDwsY5hD9TvpF8UaZ3Vg0dhJyrcmgN6xB9htnv3QYkmsE2HUww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siqol.com; spf=fail smtp.mailfrom=siqol.com; arc=fail smtp.client-ip=52.101.227.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siqol.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=siqol.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOd1hsKmkB15mzbKvwYNyNb27ieQtQjoT01iQKnLxSp+CdBg0tyXG/6ofbQgPZ0flTalMyMIFukIEs+Wgf331pBdWSRSMMymDC3UdsQU2fTql8zRnaUf96WNhplOoiBCX3vmlKJmtWqbV/wp9laEt7zY4CvcOOxZ2KUAValVXnDatHPicrbS9k7ypTpIF7YxiL8rIwWO+YGnZuNDqVCtBmOgSY46/dssTTcoyV0ABvJ3d/CySmvjwD+8YSt3VDwEKs6lDiMS5TN7ISF4+TxO8nixfdhMMjIRpdLM5K2QveGfPDhJXboaKQZ7QxM5TpAka6YdgGISF+O/+fjW3tjBYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjC1UNh9HF65J8+wYOp/nkpfBEDEexnSw01K3+GQwOY=;
 b=qDVHvQV8RmjeMOXNxhltBdPsyby0YctPoZBKR/7WsC4IfnWKGQvOr6e0ibij4e31j9lxVmL5i8ex8/INNQ1Akcyh/9siLuBwOLts/Wv186PGu90hJdWUv3vzhdi4E8tT3N6zkaodDlc5BU3Mml2b0IiScYW3tW/3TRAvz2HlU2N3dXKewNvuTEHxg2k1AQ5G2kBbp9eLzdD7VOKpSD8/NN/8oZf+ycyA5tX7wNgB7J/HOV2f4bo+xNuGml4gMQmGU357K/TyqJxT8p76jJ9r4XaxNd3ETJJEVcZKbFo257PYvKCO3w8TKAnlqy25yzHhd4+HzQHHCkKJl73Z2EEuOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siqol.com; dmarc=pass action=none header.from=siqol.com;
 dkim=pass header.d=siqol.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siqol.com;
Received: from PN0P287MB2919.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:224::21)
 by PN4P287MB4194.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:2a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 10:09:22 +0000
Received: from PN0P287MB2919.INDP287.PROD.OUTLOOK.COM
 ([fe80::ce9b:461e:d772:ff02]) by PN0P287MB2919.INDP287.PROD.OUTLOOK.COM
 ([fe80::ce9b:461e:d772:ff02%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 10:09:22 +0000
From: Darshan Rathod <darshan.rathod@siqol.com>
To: linusw@kernel.org
Cc: kaloz@openwrt.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Darshan Rathod <darshan.rathod@siqol.com>,
	Manish Narani <manish.narani@siqol.com>
Subject: [PATCH] soc: ixp4xx: checkpatch fixes done in ixp4xx driver
Date: Tue, 22 Jul 2025 15:39:04 +0530
Message-Id: <20250722100904.735395-1-darshan.rathod@siqol.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0124.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::10) To PN0P287MB2919.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:224::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0P287MB2919:EE_|PN4P287MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: 623e8d3f-28a6-4d4e-9315-08ddc907d49a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mnDWxackBAqJqYM82Ah9gHlDpxfYakSPAsxmvaYowDIDjfuo85br08VMWZLA?=
 =?us-ascii?Q?BwpjnTGXXzKB/ZGw+V8zDpHpnVZxwen9WICgBx+ouKCX+tiafOqb2WyR1adb?=
 =?us-ascii?Q?+9mY8W+IzcVWlH1yCcj182a43EMeDJNTTYcwOBckWlhV980Ei3mij9721gKe?=
 =?us-ascii?Q?GfI8rcX0WRKmr0PkGTOp0Jj5YD6MTo9+NnadgKWAgIeeOHamx/fcP5pUBgPq?=
 =?us-ascii?Q?/2myC9KayvrUnD9I1/EwtjN5K4q7n+bYjM14+jSi3K13/3IB/YRCg9Vyc5sw?=
 =?us-ascii?Q?eBElX7oZ7Z0IWmdM/Ad5uYRzx4Wvwe1lrXsvv6LJK6iBYpo2Uxen/3xtiOJ6?=
 =?us-ascii?Q?WZ6BoNa3irzg8Ge3tDFGhS9ofHn0PF/mZD+qN3aoIZDKsPrmhh9ILf9inAKL?=
 =?us-ascii?Q?HNac7iAs18zBSwHLsjH5P2nzxLLrCl4ieFnEqgZtXnP9m8PKF9oGAfEvPuSc?=
 =?us-ascii?Q?HpRi/3gA5wmAh1P8kN3O0hewYV8B4rMJCig0sl41bj7RQtk0/NZSZWcDGAo3?=
 =?us-ascii?Q?IAtcrD2v/5i6saejBhkfGFrkhn1pZGiGGtGaDIxl7X3UJnF0q6ui+DzEyNIJ?=
 =?us-ascii?Q?llPi9pmC7OPnv4Pj4yIWvjyfFkZwhEQVTma4FaSknUH+hYJbhAnGsLsBE6sf?=
 =?us-ascii?Q?h14ZUmtbC1LzbZaxio1sin+uJA9fbv9cytPXGzG3YRMNePENjymtZcPGNl5l?=
 =?us-ascii?Q?SwV7I6z6w1ZnmMlaOiBHzm47kZpCBkUu66R+N+Mz/8FID77n5MWNr2eL3FRJ?=
 =?us-ascii?Q?v0HAqqQCOUvXi994sd+zMBW4dEnyZ0al1PRe1u2HZZlJTRn18Hq6GD7toH9G?=
 =?us-ascii?Q?80iy5MJbG95CJbbiiatOv0FgPmBMITt/TLTxq+XBHJ0xknh6MfrhoHHHR2Z6?=
 =?us-ascii?Q?nUVN29HhPwLvX0vwfvQfzdtfHVcRez3WpF4OaM5G0y0ZV2ME4KhrAwElXQu2?=
 =?us-ascii?Q?peEy11Aw0JpiOU4Xup1EZgXA8ZUDrIqWWrD+vQFjTrLD8lx3MSTdxGzqryuI?=
 =?us-ascii?Q?Givz1o7apitzWosHX7QiMKqqDPOD4BR4t4EFj65cwtfJ6anqG3KYNUl7pExM?=
 =?us-ascii?Q?wN594fSKUQQTpfPYpTHng/M0NKKzpJAdZSx8cm0XxX7DYlLBzNrI2pD7LLrf?=
 =?us-ascii?Q?2ca4t0352jNSmHMjUTvfUd7GnacmnP8HB2yhzt14eU9tXBeOZe3+K3b5MlEs?=
 =?us-ascii?Q?VRCAUZdeTpxh1tAyDnsd09mzzF9DLWPZO+UOnZQm2rmkMP06KH5EAQ2+b6Ev?=
 =?us-ascii?Q?AP8ITsVBkSx7N44zoXUXTkWxeAeaJr7EOBQ0LxEL0vEGFmJJpVrOe+BvXJuF?=
 =?us-ascii?Q?o+kPOcL7ncAyUuJhbQbXJatVSv2tuRUlAkDwH2XBkeviGeQUK5vLX9tP2EW1?=
 =?us-ascii?Q?F01bxq4Yt+3rJVLrLZG7+k5MjDcFudHN1hGNmsVXvcr2AN/Lbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2919.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BCGF+3mUyZ9EwMa8gIjmnHmv3A4XPJ9luPCPWD9XeOan05106QJGCWFfD+IH?=
 =?us-ascii?Q?0rqyg2kjifbsg/ZZD7nAErapEmeBsrhe7yvBB4CeD+Vjk1R0GPkiiiqOs+Up?=
 =?us-ascii?Q?TJFrdDDzpM6Evuyq164m/MISh/3RoKvY9GluXr3GJ6a6/tZhSZqsKMzEAjbI?=
 =?us-ascii?Q?+soKN1qG8rIq1XfBRXXgNL/ZNNBwRxr9WIaPlOfzT0+REJIFwSVR3ngyEgp1?=
 =?us-ascii?Q?zgUlLNcip2yZREtbxEue61I4KXUDVhzMQTTjSVOBYlu9JJhqpgkRgpzLRQ98?=
 =?us-ascii?Q?u45vVEYhRZU2mtp8mGlYe7jpku+UeisyNDufY4XyAm7S0I8/MqDl2pjOVMcT?=
 =?us-ascii?Q?isUbYvChCmrG2Aud4sGUw496Zhb40A7N1cMceO9sMjXLAul8VNCjLk1tkBBq?=
 =?us-ascii?Q?wf448czzcEF8811YxFOouLHNEQGI8dNJKsSGcyCzaY6WBeWKPlmrs3Rh4rjd?=
 =?us-ascii?Q?NoavkQ7qz9wpkNfS0pCs5siEtS8evcSu5VPgk85xQ4qWKhWZ/lyy9Nj1yT2S?=
 =?us-ascii?Q?IrqjfVawd4Bh/d0DBnFVLD033e58MnHPSxXdKZJT5WW6ZeQMVlpOtk+Q8sXr?=
 =?us-ascii?Q?Dc9RRNJXkM96jaJyUcC+HMFemFL+J11ilAhj+7xLo2fAzqbSuDQ1OPlgu3rS?=
 =?us-ascii?Q?b46000OnIF9UITNwsVSC3hwGCVv0C65agCDJGVyz3av9lc5KbSO2HP1ecxO1?=
 =?us-ascii?Q?d8wf47/nOAxD5Gb5WIPwmFELHvpADyk7r4HAW3ZwLbJ4Zmz9F2V5QsOH7nQh?=
 =?us-ascii?Q?6EEuJxe2H3KzBM1LjnNFAS325Z02jyzu+j1mYEWhyNJa+LcjJcwpTT8C3ICQ?=
 =?us-ascii?Q?FhEs4xB6HGzv4n2qxbwuLiMK+rKFvMhz0ZOUKWPtDIlodksLvCuqIHYkFX2k?=
 =?us-ascii?Q?GDoZ8t8cQsO9zRvfnIsytCEixNkrZrsoCpRcbYzLlwlsB8EKna//vQl0wVE+?=
 =?us-ascii?Q?wAKhevXim82lwhpQwzjYbmd+Tmct4+YPc5O8er7dGVuv28F6A0WKoSdDH8Hq?=
 =?us-ascii?Q?tbZltRwvTDE5/cKHkIl6BjVN199qaheMHiVoyGEAkcdDq2xiOUpWDBqvJoDb?=
 =?us-ascii?Q?goynvFBD/vEjaGWl42y6YnwvWqA8YE4ivUIIKEwmPM/Ow/Vk6FPkN+oNbk2A?=
 =?us-ascii?Q?4N0ZiX41BHg+IIasRon3v654ZJP+eMdgFmh6Ne7sThATM8upaBaQqp3TDBYw?=
 =?us-ascii?Q?mT93sTDLkkesByklH6cYo/YWX72h4aluQhYWYyXAkfIJLZ3yCCtb+dPMEoZ9?=
 =?us-ascii?Q?YpEk1KCp8mYDT0aHhSdL1TbEFfFC1njcpirhGcCAjmOU6Q6FMZflbF+3PFpb?=
 =?us-ascii?Q?pT1kcyRSVCmIB6NzuUbyduA7+PxmqVei4alXjljyFpRkH+0xbfp4xjUZ6Pr6?=
 =?us-ascii?Q?sR4nYP06VFyFewWs441C939UWjqPxn33/c/EhJ4lwsTO6Vjd5uHGEvQq4uJ+?=
 =?us-ascii?Q?cKz8jNkDRWbo5452NdFLu3/ky3An4g4pUd8FbSoTOhd3x0+mQ2KS37wdESRO?=
 =?us-ascii?Q?p9+XhnwPFlJfjEBW3Yi13XwAmuBUyeiOn6kecI7joVaHLPtbbKNEzgLsufdG?=
 =?us-ascii?Q?MNgtnorZMVsObyHehgujpR9vMcqU8z8/aJuQ16/4Keb8sZAIJA5THbba5qaT?=
 =?us-ascii?Q?bMBGpM9lxKjUCqGkTHx5Fyjs3De40A5AVf2FrNLypSmN?=
X-OriginatorOrg: siqol.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 623e8d3f-28a6-4d4e-9315-08ddc907d49a
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2919.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 10:09:22.6752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e93cdbe6-5a59-4d5d-8570-7b6ea0400c3e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmyyUwPsMFyrIJt3FtQ/jL7FGjdO/83UOEBlAym4n9Iyq0FMbAxFUC6kiD2gIDlsjqGRsW8JuKF7SzXk3rzt/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN4P287MB4194

This patch performs several code cleanups in the ixp4xx-npe driver to improve readability and better align with the kernel's coding style standards

The main changes include:
- Refactoring 'if' statements to separate assignments from the conditional check. This improves clarity and avoids potential confusion with the equality operator.
- Adjusting whitespace by adding spaces after the 'switch' keyword and within type casts.
- Removing unnecessary braces from a single-statement 'if' block.

No functional changes are introduced by this patch.

Reviewed-by: Manish Narani <manish.narani@siqol.com>

Signed-off-by: Darshan Rathod <darshan.rathod@siqol.com>
---
 drivers/soc/ixp4xx/ixp4xx-npe.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/ixp4xx/ixp4xx-npe.c b/drivers/soc/ixp4xx/ixp4xx-npe.c
index 33e2e0366f19..d2494310ffd9 100644
--- a/drivers/soc/ixp4xx/ixp4xx-npe.c
+++ b/drivers/soc/ixp4xx/ixp4xx-npe.c
@@ -466,7 +466,7 @@ int npe_recv_message(struct npe *npe, void *msg, const char *what)
 		}
 	}
 
-	switch(cnt) {
+	switch (cnt) {
 	case 1:
 		debug_msg(npe, "Received [%08X]\n", recv[0]);
 		break;
@@ -491,9 +491,12 @@ int npe_send_recv_message(struct npe *npe, void *msg, const char *what)
 	int result;
 	u32 *send = msg, recv[2];
 
-	if ((result = npe_send_message(npe, msg, what)) != 0)
+	result = npe_send_message(npe, msg, what);
+	if (result != 0)
 		return result;
-	if ((result = npe_recv_message(npe, recv, what)) != 0)
+
+	result = npe_recv_message(npe, recv, what);
+	if (result != 0)
 		return result;
 
 	if ((recv[0] != send[0]) || (recv[1] != send[1])) {
@@ -533,7 +536,8 @@ int npe_load_firmware(struct npe *npe, const char *name, struct device *dev)
 	int i, j, err, data_size, instr_size, blocks, table_end;
 	u32 cmd;
 
-	if ((err = request_firmware(&fw_entry, name, dev)) != 0)
+	err = request_firmware(&fw_entry, name, dev);
+	if (err != 0)
 		return err;
 
 	err = -EINVAL;
@@ -541,7 +545,7 @@ int npe_load_firmware(struct npe *npe, const char *name, struct device *dev)
 		print_npe(KERN_ERR, npe, "incomplete firmware file\n");
 		goto err;
 	}
-	image = (struct dl_image*)fw_entry->data;
+	image = (struct dl_image *)fw_entry->data;
 
 #if DEBUG_FW
 	print_npe(KERN_DEBUG, npe, "firmware: %08X %08X %08X (0x%X bytes)\n",
@@ -624,7 +628,7 @@ int npe_load_firmware(struct npe *npe, const char *name, struct device *dev)
 			goto err;
 		}
 
-		cb = (struct dl_codeblock*)&image->data[blk->offset];
+		cb = (struct dl_codeblock *)&image->data[blk->offset];
 		if (blk->type == FW_BLOCK_TYPE_INSTR) {
 			if (cb->npe_addr + cb->size > instr_size)
 				goto too_big;
@@ -741,15 +745,14 @@ static void ixp4xx_npe_remove(struct platform_device *pdev)
 	int i;
 
 	for (i = 0; i < NPE_COUNT; i++)
-		if (npe_tab[i].regs) {
+		if (npe_tab[i].regs)
 			npe_reset(&npe_tab[i]);
-		}
 }
 
 static const struct of_device_id ixp4xx_npe_of_match[] = {
 	{
 		.compatible = "intel,ixp4xx-network-processing-engine",
-        },
+	},
 	{},
 };
 
-- 
2.25.1


