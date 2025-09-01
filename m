Return-Path: <linux-kernel+bounces-794638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC6EB3E49D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E6C3BD8FD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CD8277032;
	Mon,  1 Sep 2025 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QXxYOFKf"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013057.outbound.protection.outlook.com [40.107.44.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F221DD9AD
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756732814; cv=fail; b=ZyRcX/rwW3Ddkq49ZEPWGPUcGM7TWqCz1liH3RVh9Ily40QpnphWanH/eHsst9Uy4nBqlVZ4RwRVF2IFMceI9putYbwh5cmXP2duAiVznJR1oboI70vYL5Ssx8+qdLvhtkqCX/R0UQVggLdCB+0ny0vgMGLxcrlwuMSAgnj4eD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756732814; c=relaxed/simple;
	bh=4Nlc2IMiIv0BI2r7hLtJKavsYCZyKYMlHewZal/gJMU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DQX/VSIP4HRuH3AlnktppYS4oD2ziYQ0LMDUZcU2quM0dVKc0mnDKBLaPn87C8ubkHJgmZDEBZYyjPvnXQu3rMNXqKIq40oX3kWnctz4HnWFNKtBDzpAhnEUcI1wXnWkQGuT1dMvbD9MdeR0FktzGYBoUk3hyF/NeEyrO+8QeK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QXxYOFKf; arc=fail smtp.client-ip=40.107.44.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5eOzrbhqS0Au6NTRtuLcFIEA4D2RfOIN2E2L5C33OalMLUp660VIlX93F/HUE9fUFgtfYKvbAOjY2vvc9bXUhddj1zq/LhqL2Eks6qGmvDhXT9ElaHkOafjez2UBB6IflTa992dnKPrlopFu1CAT5e8un41yF0/HlVY5EQ6g7UvCVA8VYG3T5f0O2usg7lR6kW3u72NKak8qdvE4wh7Lyj8UHSjyw8P2tssrbl4tmcEozyvMKMUVWhZBEzIUeyqxIfTUvYkqn2GP9+xKM5iy4JnP8FwqpLWsclwYpDlIXZedc2r7qtjt22+NbYfIdTUPmw01BU6sSI8L/gxFlPTbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHxQIJgZt4nhXLm21HU6LAEJT2f/hq3By32BAPIucZU=;
 b=eK+aRHsRJ8Qmrl1Ne3RzbJW5R8wl0luJIaonWbOONVxybCiQ+xisSUfX+Ww7iVca007orGuL96qubBVYQQHe4Or2PP9y5z/wgW/vDp3LxDij+eI1MmoXVVV3HWM4WcDUuat+ZFiPUf4yVUryfeFbpTSkVHsXyfqsezTyuC/XbO29mfUxnnEmGCMlTbf2RyIxx6U9vp+pJ6ta3RcO8ztvfuiBU0St+niEd2AlQS7zyaxW38zWTtsI0niMDCL0LDEn0T6fVrUvcrVsw4XmVzncf1pAmcZyUIxjpv4+9H3H/J7gMLcOS19RJ4xIE/APv3tGpUTZ/eqf+SYf0AbOd6IpLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHxQIJgZt4nhXLm21HU6LAEJT2f/hq3By32BAPIucZU=;
 b=QXxYOFKfY7DxCvMameZyaMj6akIiO87lyA1EwUt1BBLeZthEgM7hufVTg3eP5WeWY65ECsHCvuqFsu8TyxB3tjQ0l9VB5l3tANZ0ML5+QPjO5T7kuf/l8GwG/CJChNHrXsYH8I0G/0qqpPFiqw2+gHynCO2SgtR6ttWebiLtzPWz+zldQ16BtyARRB1g8V5UZwbchw0kkaFvv1yZO5QxUnP8R7wWt7M4+35EMxlQfEq3al1OjRXRRXVt0l8AQSMYgCoXhPcuV1Pk91961qMJyE7XxkZiNqiKBVCRoyn3E1HhSwTJfCQH2aYAZQMNpYNeQvKRMjaofNchrrAzHgSuSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by PUZPR06MB5698.apcprd06.prod.outlook.com (2603:1096:301:f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Mon, 1 Sep
 2025 13:20:07 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 13:20:07 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] x86/ldt: Use guard() instead of mutex_lock() to simplify code
Date: Mon,  1 Sep 2025 21:19:53 +0800
Message-Id: <20250901131955.649000-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|PUZPR06MB5698:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f675e6d-2825-4c6e-42cc-08dde95a454c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?guMR0YgNDPfI5UNQI9yYlgUIfyflUXc7fLy88QawidtfoDfqCOKRtUvd+hk8?=
 =?us-ascii?Q?Doy9bBKiuxpojZz9P/H0sSWwq0u9gMHYL8AOLhv5YJXE7xF98FmNNo6pkXY/?=
 =?us-ascii?Q?VQEHyC+aBqynCmIVge0d384BKw4Fg9jRPL5FHdSIdqLTY3qfSqsYtdZ4iyFX?=
 =?us-ascii?Q?c1aQTOA+a24JEwbxdZVGfKzzk/8sbgWh9zoo67JvyXzajoEGkCZzbIQd1RM9?=
 =?us-ascii?Q?t70UR3bcLCCIbR7+C10Os0AiEGvWRzAQOYJTb2tlVapK6aMrNPHCOpEJzsiB?=
 =?us-ascii?Q?8NHk7RP9plQAgLvfs5IoBvelBPNY/8r1VxPgTbVWMpF/dDOJn6Ny/X7eVNZG?=
 =?us-ascii?Q?U/dYs6PyhoEhjTiCBukFIc/YOpZUQ7WGjFyo1IsEf9qNPj+EyDGODX0+ZMjM?=
 =?us-ascii?Q?NMCLc2X4Z88T6QY1E+cjBFMBR1+t6Y2nrd5qlXeB1VRqsbyjNTfKFZGeA3UU?=
 =?us-ascii?Q?40vVK22Rb4CaF+vJdQVL5l8b2mV5btWPzdl3suKQDRaZnKw6c2V9Dhg9bk4m?=
 =?us-ascii?Q?Nmy1/3ZNNMVI+dNMgNEHU2TEkIdxI9EAnAZckP1mbpsRJjh3rSexDDSp+uuH?=
 =?us-ascii?Q?OgLgGalXJa5u1vLfbNwxdRYUeFrK4luhm1w6V2MheSUCl889apUv0Yd1LcqN?=
 =?us-ascii?Q?u0dRY4RcXO5bLpBn4aaUZ2p+afrg//vTwmlhNR0v2NlAF7q64w7HEODCyZdv?=
 =?us-ascii?Q?393aOoVBYbQ58UIQs94EfeMJh/Jm9M+D9KBXZWbyVtMC1U1iI2N+zmDJJQM3?=
 =?us-ascii?Q?EEq/H2V7Hz1xAG1sfW+pI5ekSEiLynB8h6s4ndEq63isUqnjjsnCdypp7vGM?=
 =?us-ascii?Q?DljRDiKLZ2W27qAYwg3nRQ6F4TqJ5xxHEAtpv64lWT8Xg6fRFyFZfhxx8Xm2?=
 =?us-ascii?Q?PDTSnMl5doT5ORItU9UTw39IH/ygMcsDxfhfGTYrryAg6uhKDO64rPfm5Q2z?=
 =?us-ascii?Q?32Wwdi98cYe0G/Rxi9aUc/hEtyR9VJy65/95y4W2a6XTfB4TUkxi8qZi/EWt?=
 =?us-ascii?Q?ACikrGh9AoS9FKcRpVKSurIQrVvL8ZWSVsXcEqnCKK9xlxLVPXLh8cjBDVGm?=
 =?us-ascii?Q?mF0RhD/3+X6ztOV2d6NHoglrjG+TCD9vZDujTq9jL+uZFCR3YXvpILFEQ6oQ?=
 =?us-ascii?Q?8x18OdhNyxBomWKu/OQjXyH8JA6GXlgh8YutVYqERUH6X54DSUcJWiNABPp9?=
 =?us-ascii?Q?5+UG2mX4zZmKb1UYsZEWRPKCQ5fxT9AD5syqLxxtWxqYxzN4hDGkFA79pvxi?=
 =?us-ascii?Q?YS5MrlediMZSY1OMqeLiTe4Fh+D5HHn4W1GHJRP2x5RZS2rEi/zKY56YVXCJ?=
 =?us-ascii?Q?0p4ZM8cFoq/V2PsRJkwuqqqfIGSh/QFZV0rBm2Bu8IR/4/bE0WZbbW9RPvbw?=
 =?us-ascii?Q?AlwaW2q0FDou2URhyhSWdDEGkd6U0DgbEXI39ebLDNpLS0vNZol9zluMcMsW?=
 =?us-ascii?Q?s1deW/91pRV1dhb2+7XUU5Cxu4DR6mh0EdRfRPERQuMGhqbxkpb2sA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Ba9/i4344qXBJLEkGyRWT7faIlFZX8aOxBEfCYOPBWTShp/fvor970dx0fZ?=
 =?us-ascii?Q?/Irgmcp39GDyfjXd9Mk7afitK3uYECfq/ZlRguVK+ePafQ3w9k2KrTqEq7Y7?=
 =?us-ascii?Q?G/eDCgafxGGLzDbM+dbHk8hCjO6Da7LemAkSH1jfZKphAmowXmaSub55VTcs?=
 =?us-ascii?Q?awmkCWWpPC58YJnPKmodDPinN0WB6VBhXBqLplC62OO5oVqQCSUKBqZzmyrq?=
 =?us-ascii?Q?e2oPm57NeAh7u/wS1NEs33MKnlwwqHhBCnDortkIAYo2xnB9T4qut9JC23Jl?=
 =?us-ascii?Q?FvVD4tpzonG9roo9VqZuMXXyRpcaunQzzoDfw73Y44kxSxxe7/HQPKVIkWnU?=
 =?us-ascii?Q?ZGTLtIuiddeIjfq1v30HCxyyVf2icB7oFsHsB+eFpFhm9H9+ESckdDaP/8fh?=
 =?us-ascii?Q?+31RGXgSInujVGj39WiZ3Gt0unYMEVsVwboyPP4h0kHopRYDBTioVuYtJO+6?=
 =?us-ascii?Q?8u1mp9vUs3YMco5lCbN1c7A7jylMc64acgLP6gWamskKr0tEtOo39OgOjsVy?=
 =?us-ascii?Q?izmxSahb/XnfcasnLyNZWc+MMmUqvvcHYO/iZGWG2hMfNWwLenyHhUK0vHfE?=
 =?us-ascii?Q?qV9ZM+JPXtcdxfcKdP/2RAj0z05cs5cjVs+FCFvOhUj43iBqcaPQO9T3Xr3d?=
 =?us-ascii?Q?RwCfkNt+7739oBlC2kLxV48KmsDq/Jh+9W5DCaHZTaVQe8tG6N+3LNwW8KkS?=
 =?us-ascii?Q?GfY3ZPWpvfez1UbLg3KUbo1kvVQQrr8CceATQ1dv/zwVzeOOYH4b9S8yv/pA?=
 =?us-ascii?Q?HrVVE/CcXhDolUDrYIT+K2DNl88jbf/ah6QgdwPPJNBkm9fQL+oGmVJHePIc?=
 =?us-ascii?Q?W/lCZaHXnHqQixwpMgz003MrGwo8j7iF9I0psKaE8pE+7nv/ufZqQlc9CArJ?=
 =?us-ascii?Q?3quKhyPAFbiTneX4KAjJG+PHpM7j/BzCZxJt6siKvflk18NU+++Ht/XDfTeE?=
 =?us-ascii?Q?KMWC5BMHC/kb1XbQNqew+rVja2UxpunXaD12M/A0eVt7RMIWD7+xTFpSfrFW?=
 =?us-ascii?Q?YOn0+xG9FmjR7NbFuIQpzo7gqpPtiwtlqiIPZVDDg/l86yagxiMoGCLJqbkJ?=
 =?us-ascii?Q?2VlOn80zee3Tlm6g5GjgBgSGEMV28m08Jajbh8VnZfkyFKZQybGnrHSnnWpF?=
 =?us-ascii?Q?2LCLN7jXJpLz9oK+kGcrw5n04hYY8Qx4IR61KM0gAeQ6XTp7V5ZpQmYDWGeN?=
 =?us-ascii?Q?XSKPUjJCNxjlI+IFelbCY51CzTpnOwF4oWv6hBI2ImA/QnigbojjuHIaIxpN?=
 =?us-ascii?Q?USsdzmaMnktrXMfCKlK0oIgmDgpsX1xNbSSmDbrPLJUSoTA/PtZLkeTNmXYs?=
 =?us-ascii?Q?DkBQPKXoIKtH8DM1ZkyDbaNsjoxTZcC21Nl+trbG1AQXDcb0vPtEBrEJICPv?=
 =?us-ascii?Q?qbUZUPD63TUXx6Y5WYjna9O5Ta3FHnnHVExLBHRIJnVr27gbyoj7c9nuBi7H?=
 =?us-ascii?Q?e284ggG0hr39mWXRxiW9jb7PXAWfZBjW7LfiXHU82G49MA0EiY/ZKf43CC7R?=
 =?us-ascii?Q?cYEzOsq4MXLgXGm4bzSxsHaa9rlG0yvDeLFTRtgVV/qm3evNLqQPG8yAJ4dz?=
 =?us-ascii?Q?ciAKVgyhG/btsJXwFGR1qnJWSizsZUv9qkEGqyEg?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f675e6d-2825-4c6e-42cc-08dde95a454c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 13:20:07.8088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NFX7pyyGWn33+OwA7KE0TclBOnOHrCQBL6V9b/fOzRVi/HL1mhtL/l6VBGBECAVAdohHTVuFyKmw7UDQuXAy6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5698

Using guard(mutex) instead of mutex_lock/mutex_unlock pair. Simplifies the
error handling to just return in case of error. No need for the
'out_unlock' label anymore so remove it. Similarly, the variable 'ret' does
not need to be initialized to 0.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 arch/x86/kernel/ldt.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 0f19ef355f5f..4dd29d521928 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -451,20 +451,18 @@ static void free_ldt_struct(struct ldt_struct *ldt)
 int ldt_dup_context(struct mm_struct *old_mm, struct mm_struct *mm)
 {
 	struct ldt_struct *new_ldt;
-	int retval = 0;
+	int retval;
 
 	if (!old_mm)
 		return 0;
 
-	mutex_lock(&old_mm->context.lock);
+	guard(mutex)(&old_mm->context.lock);
 	if (!old_mm->context.ldt)
-		goto out_unlock;
+		return 0;
 
 	new_ldt = alloc_ldt_struct(old_mm->context.ldt->nr_entries);
-	if (!new_ldt) {
-		retval = -ENOMEM;
-		goto out_unlock;
-	}
+	if (!new_ldt)
+		return -ENOMEM;
 
 	memcpy(new_ldt->entries, old_mm->context.ldt->entries,
 	       new_ldt->nr_entries * LDT_ENTRY_SIZE);
@@ -474,12 +472,10 @@ int ldt_dup_context(struct mm_struct *old_mm, struct mm_struct *mm)
 	if (retval) {
 		free_ldt_pgtables(mm);
 		free_ldt_struct(new_ldt);
-		goto out_unlock;
+		return retval;
 	}
 	mm->context.ldt = new_ldt;
 
-out_unlock:
-	mutex_unlock(&old_mm->context.lock);
 	return retval;
 }
 
-- 
2.34.1


