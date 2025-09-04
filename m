Return-Path: <linux-kernel+bounces-800654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD770B43A22
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8218017167F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B299C2D4B7C;
	Thu,  4 Sep 2025 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="gRsz/rGQ"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012050.outbound.protection.outlook.com [52.101.126.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661BA2F068E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985390; cv=fail; b=hxUdu2sUoZOMCXwjXL4c5Q4XpTCLrRIHgOBj0cT5r9MDfJwR0iLuKl8qQuET7Ubx8XlcwOqW2X6B5GNMaYDO682FFGDcwx9dfsu8UyJjTPhQ8tvy5xXv26xuajU9xEMyvaYE6LtEgCT69H+/h10fnuLKEEzODFWjTdfVy3Gfgjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985390; c=relaxed/simple;
	bh=4EKH8Cg4XPgJ+u5jLQWUwWr5HLPczJxFVl96DCyo3wE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=esVGJEfis/3xZC85Q6aYmBMRXJF8U+4NkNGGuCZ1WrGjLo3ARVtD8D/twzDOtjV0C65UvoXBGCUAWckE1WV4N/8JAVJIx1hK+Y/RUec/cEdFm39OHD2G8KZe6hxdAuLZGFA3jrGcTPXDJ/y8WysvhT+0SAkpRI7Gxxz9LOIDybQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=gRsz/rGQ; arc=fail smtp.client-ip=52.101.126.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFwDh6O+gDQ5cDRYtv/fvlLFKVEWty6U6WgEvtBIHLq0O+O28kUJKI8ioIXUD5o5H36yrH7CH4rBR/ernPjSZHsbtjtlrz9nIQohMgQHwBxWdVpfyEGSF/HE0BeCdQwb2AhztwvkWuK4P/M/+NiQA//L6YSF2KMamJqdaW1K8Qv8O62kieTgHfvwgo3B4rQh8wvolCXx7xv9HSPmo2XfL2uT7VS4URVx9STzHWuOV+NAJOhCVGM6fPz1qDvps0FqO0siQPZLAD1Aj+ojmiaGoJFFyrK5P4ZclWRvY2GoFkdxJMCYeSaWO7pUypBD0KXvi6WzlonaA7Arct+oU4v7BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5JkVs7kZsQ8eazkl5cF0sDe/BRsrRp0tAS6cLkU4PE=;
 b=REgCxUfoYSR6CjfEIJH4j/qAqPhcX98CifO2BigZcwzR3TaNoh09PILacZL3wRHgYVa9q4m+pLP9yzndxiHylAazCHcPugxs12q/88nLNkD5ev7nN67E72RsRDEMg1Zcd+y3yWibmoEEer9ryG3IeSO89Odc51W0hyiA39iOZLdTEKJQ/hIkvrW+dRh5cckO3aCYVE0xbRoFErHRVHopLqlDx+mAO+bbZauOnAzPmR81IHJjwePOD5smq6lhe6QCEQZZdKqkT0dk97ymXhYq+9zPP0V3/nyQwp9lX7/F7GqVGBx3MEcfIHjw8GP0he4CzW0USJU8BLSW3iSzbNQCUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5JkVs7kZsQ8eazkl5cF0sDe/BRsrRp0tAS6cLkU4PE=;
 b=gRsz/rGQdcAlpGpNME0wQNlPu8HXG8mT3S7YTi9fxT94VIbIMsq3gVsCDntxYYA0OVbjdmVdskFED56N/+++ImcBldJ20V47/v9bT37xQyC36GnXe70w/52UfCkN2jjDecKL30n189SJ/P3rWClvzPEl5PZ5yeahTXaKw/5fPfmwFzLnNZNHzsTQsM2rU5NOP9/NTvz01+SI5qFtxvOzZ5MMd+THzsHgBeKhc/QVaACV+acjq3VR+5PRiJEhAYsmUlJr76Z64HmfaFQcNxd1g5X0g2nU1HUVRpSjcTfkJ1AjqLQKpLB/5+utw5M2BZ67HB9XF+arSaS5AdeGMdS91Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TY0PR06MB5753.apcprd06.prod.outlook.com (2603:1096:400:271::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 11:29:46 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 11:29:46 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	linux-kernel@vger.kernel.org (open list:MAILBOX API)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] mailbox: bcm-flexrm-mailbox: Remove redundant ternary operators
Date: Thu,  4 Sep 2025 19:29:26 +0800
Message-Id: <20250904112926.351309-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TY0PR06MB5753:EE_
X-MS-Office365-Filtering-Correlation-Id: 2547d6a3-1c97-418b-cbbc-08ddeba659ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DJ+LauZDfQH/AHgcRmOkVXL8UedZ+QJm5YmaXGDh/DcUPFlMdWmgab38lNPg?=
 =?us-ascii?Q?W/cnlGNqeH4qW7sHEeHHVZR2TTgwGv53oydGqto4kS+NlUm7U14ZLldusNKM?=
 =?us-ascii?Q?y6790URhYJUUdECC+tuvQj2PV5qoF9JvOt/XmfR0h5Wv7nbT8ff/oEz4cS81?=
 =?us-ascii?Q?zJcyNFJL5TDQCBOQpViBlPla4LS02dfR4fZUHEcPbXc5/69lwG1t4EZ7aJeX?=
 =?us-ascii?Q?/xe/5r68PPBOzUBhK06j/ugvNtZgvsLhPPBF3eThlkaHvEirwj0HI4ScgWWz?=
 =?us-ascii?Q?eyLfH8vdcdO9AmkoW4PxBmyRuIcStUFI1x8vZhKir9FiMYQdq7qFR8KElite?=
 =?us-ascii?Q?RE8vcoHK5TmHnW4mEtiguBf8ozcH23zcilt10OYmC0eGdnnip9HV3LbAdjCz?=
 =?us-ascii?Q?WaXX0Pcm/5cBeTp9dgPg6R2yfQsmMmEmiC1wRMCoy8kGZrCvFJW/jVcHXfGH?=
 =?us-ascii?Q?56eGNl1DPQku+OljsqKn8xUag5QA6tr5n6W/ErZ4KuAw46/Fet1ZUCiMihS8?=
 =?us-ascii?Q?e0x4hU5f9evB9TCAHixAfNoPpahP35Mj7jjemm1Pxe2rcNcxOqyEawkXQ+dt?=
 =?us-ascii?Q?b8dsQEp0q4IiR8qV7Te+M9ahXwNpqpB0GuAPBJ9eekMG0cv2tptVAIK+GkYa?=
 =?us-ascii?Q?P/BfykW2s++mOhSUzCcZA0i3OGDkqJDZb6s4uSrKiexZmVANzkoCVAAWi8dm?=
 =?us-ascii?Q?Bc3MRtrlDVh1+GKLyFilA+HIUAPIH87hGTt+uMu1M53AgyQyK1I5EXA0+LQv?=
 =?us-ascii?Q?LETBT3zh3bL3tcHmPMUTW6OWpCq+k9nDwo6dvSMhtzpxi0xzwCu8cmwSGIum?=
 =?us-ascii?Q?qQzKhgZ3u6gmG3B7gjTF86HvmazoM7a5BlfQMcMxXKD/2X+tgFCWzeXgLLQK?=
 =?us-ascii?Q?ZHDL1458Fx1N+xhSjH5r4L8qXSWecatav5rFixPriyrvhl6h+YXDfppLIMgI?=
 =?us-ascii?Q?hW+apH6HQyXO/fhSkUAIzziVC9BKAkYZs0jgXddaqMDcBfnGhYyOET2JelSv?=
 =?us-ascii?Q?j5HfCjFdtQs688HuVsY0hHs/M3kGQpB5a/4PSVFL1X5YnpcR0UXQrLrT3cvm?=
 =?us-ascii?Q?oa0R54UqCFCZasRaE/wWh7oazkQRo5LvcL7fYHK34S2b18ANlJfzDvgr/oVV?=
 =?us-ascii?Q?upv01hXclYr9om/2J0YBd/uU7fD4t/0BK2esJsbG7GxRP7cUIFGGNwMwzyE2?=
 =?us-ascii?Q?i+gGllvnTgZ5rghnTLAg5St9mm/AXiqh++I8S+OAap/fN/Bmri3rgZZiGdkj?=
 =?us-ascii?Q?3anCyT8revOEE1ONIHf3N00Nt7pVuTzBcyY8kPDU8F/Y7IosFSpjht1iit4i?=
 =?us-ascii?Q?2xZVARFGn/1GOqrN+11EY0sTEoDMTYOrBxmHRVggj253R+w8tABmNwnawkHp?=
 =?us-ascii?Q?Ucs65jYLKSSJVSKWZSV5QOrRJzh93wBJLmOk3f75x4IOweRNWdwgunfMlTmO?=
 =?us-ascii?Q?sDyjOpVtDJ4+wSgYuNboIKv6YHQt0U3IVUwhpad2mb+FSbC0QMwjUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kKuD7aOjKjWguB0LqzqrYITivB6Pv7Ya0sN0m6qeajLIyHCLD5YUpOW7Jdpo?=
 =?us-ascii?Q?cr8xzyAIKclPz2bDZZEAGclZTbpQykNID94TUBU/5lcLXPx+kqnHRbKyPqr1?=
 =?us-ascii?Q?TBWY9G/lnwZWPSYfU7RRzpqZm5c/mP+lcdvRYm0VyKomaa5BhMdtEUIDXIpI?=
 =?us-ascii?Q?CdksZT+I7VY0Y/V8uspGtcI13JJFhA0YASJmSrUv1AqBtx7WvTU7aYNt+5Wj?=
 =?us-ascii?Q?ds6HdugUnODcVAcx0z5sKZQRzUL2ihcA7hxuy3Z2Mp7TwhA8iYCcKDePgh8L?=
 =?us-ascii?Q?qpxEl5dytVcXsdkfW0xHHh6ld9I7CYEFdWtBPnncgKI932ygpNgsD2Osaz/C?=
 =?us-ascii?Q?KMshVe2svpVcRJYwP7IENERVM4SPWX5mB2H6EfBVXMtw6Vx4vRs4QOZhnqGa?=
 =?us-ascii?Q?qT+DVVg3U7PMcsCo/EFojM5P7kkmoErTrwxKUyLoii+Iy8hWVo6vNv+onH+G?=
 =?us-ascii?Q?H9isJx/sfTz0u5lDvYsToBiFBrSJuV7UjGVDMTX07q5QsVgcMOFoXhLNlflj?=
 =?us-ascii?Q?ZKfpRNHpgVCNkw1HvW6GUvqrEkIMY/3CKXFMF+1dTS94Gsj3e/NaH03NHw+3?=
 =?us-ascii?Q?l++1YeXksi3jwQRVYI/2VXc3FPc3KBXjB9HikU5RW4ShDhIAgUdO0986XcAr?=
 =?us-ascii?Q?qSaG3ZmTKTdlBBRKgk7KlNVRjVcO6XheIGtPZ7T1vhyXlCz0+00so0rtuG2v?=
 =?us-ascii?Q?gBf3wW8JMTBFWue/YCmu0gBjJJYUTPyknwdQAfd0WOax0emNn6ega5pAnV0s?=
 =?us-ascii?Q?88e8u2pDD63Jy1AW/HSwrusI1RDPqnPaDZGilOJBqEKO+EwmurG7mRn+4y2N?=
 =?us-ascii?Q?pfAQcouz1/mjO40z5/ElVFfWsDcA6qcCvhDjyo2PINBGTE7SQwdPrepqpb/D?=
 =?us-ascii?Q?+7PIv2qNWaNOsKB/01VeY5X59mUVHBUX3eMfTAPIBiulG8rYBe7sgbTmtGfj?=
 =?us-ascii?Q?NLGQzTW3HvU5cRhQ4p8s9Yu1vZm+yzC+0+nTTaKbfLkXHZNjH+tlHbtuqWk2?=
 =?us-ascii?Q?RluuyAHTpvntZKhzPPW2OLAQkpWk0wrAcWlhZZVqBJfL0MW3s23NQYkytSuM?=
 =?us-ascii?Q?a0YazRuIEjKMjR+wuPq2hPimiJdwQbz/HiFnXGZhcZhAo8D8mVXpSc22LlNe?=
 =?us-ascii?Q?edUuhTOfhHZJwpmOPVZtSm5IXVNTnGCQ/OZ5NTP3yS5eCwxA8WfD4eJuhWDH?=
 =?us-ascii?Q?tTCgk4grmk54IhKp36O2eExE+V5p/BCpmNn+6dYtDyytXh94vsjgOGlCmzPt?=
 =?us-ascii?Q?GWxwUU0D8tW/1TUcvWWumEnBiGk/kvWTyyHA8ANKiZSfLjqX6cpzX8LPGBGu?=
 =?us-ascii?Q?ARAqnbIdTNXLmq9ZnPrD7HyoZTT1e1CQt4IDNprufYQT/HDsdrDhIojhITEY?=
 =?us-ascii?Q?bBsGCHugFN4BB+ZN+ICraqao/S76zu/yxudCDZiO4gyFOaDpXCej7jykKRUs?=
 =?us-ascii?Q?7Z+s33AerqihVK1DDf4dd9KTWos4o9KBfmgN2pUTHL0ouEviM+gQhE3pUSk0?=
 =?us-ascii?Q?V4ImGDAWZo3nckJnF/qmZMnvZH7henEJXZGEnn8I7O2fpwqUUY0SXJfY+MLk?=
 =?us-ascii?Q?dMRM66ystMAKCIJwxP22HgWSPjKGFY8iIJdYBISk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2547d6a3-1c97-418b-cbbc-08ddeba659ad
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 11:29:46.0722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctHYfMkuz9mlM9ZuLQc/Bwb6IpTya1KKJf7qDevx7JBXDf/u+WQRrhp/NBkp9JOgUQReAuIKG9oSe+erghjSiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5753

For ternary operators in the form of "a ? true : false", if 'a' itself
returns a boolean result, the ternary operator can be omitted. Remove
redundant ternary operators to clean up the code.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index 41f79e51d9e5..99b4cdfb82bd 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -329,7 +329,7 @@ static bool flexrm_is_next_table_desc(void *desc_ptr)
 	u64 desc = flexrm_read_desc(desc_ptr);
 	u32 type = DESC_DEC(desc, DESC_TYPE_SHIFT, DESC_TYPE_MASK);
 
-	return (type == NPTR_TYPE) ? true : false;
+	return type == NPTR_TYPE;
 }
 
 static u64 flexrm_next_table_desc(u32 toggle, dma_addr_t next_addr)
@@ -1217,7 +1217,7 @@ static bool flexrm_peek_data(struct mbox_chan *chan)
 {
 	int cnt = flexrm_process_completions(chan->con_priv);
 
-	return (cnt > 0) ? true : false;
+	return cnt > 0;
 }
 
 static int flexrm_startup(struct mbox_chan *chan)
-- 
2.34.1


