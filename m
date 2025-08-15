Return-Path: <linux-kernel+bounces-770033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C53B27620
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C12188C69B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAFD29A9CB;
	Fri, 15 Aug 2025 02:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="NKEW6fOH"
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011027.outbound.protection.outlook.com [52.103.66.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72861299949
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 02:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225259; cv=fail; b=bio+CjRT9afvR3tHBwVb1dLkUSEctI2eTbKRszvS9h3wlQhOjuRxYOsbwOOxmJXCGJRTncdOcadJi8P+2SUZ+ibkISFbTPLCzdL50beMIGy/X5M120U3dhFCbtm62jOvHC3r8XYs5asnRB+gsm1/dcWhLRfo50OtghHjjwIynQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225259; c=relaxed/simple;
	bh=jVaci+nDhqSXnDtnjCWcV76pGUD1IBXFsx1De8ldNLg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Gmj5OtYXo1R7fpFUMGB1Ze+gzBVvwyhNxIqLJ3vRW3oTt2d74F2zgi6TqWNGa9qfujIJMp5wTltg7NmBN+6Mya/IYb0IRnbT8kBd01z52eiYxJQzKQTUXTa8/Y/J6L0dPEoN3Arj3T20MlmtCPAUiRRHfx1vwy/Zn5iQMmzS3dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=NKEW6fOH; arc=fail smtp.client-ip=52.103.66.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQnLsNebdTxCDy3Qr24NSIPZFylmY6b76dSwj2FneOFrhVc/Ogceg0cXGAeSuS4G418yaGUuO+fr5yb6dvDCWLk5W+c6DaUqdYlelkeIe8m/g1j4jIv6A5CjHP74rE6FyZR6v+AeFTaguWOSrFb5Q0hSrrdTQszegOQKosRsTun/M+rg/eFE7PPTTEU9hKxjIxNM54NjV0g8YAbgGP4SRqsrAq/VSXHSwtfJ3G1b9FW4SKDQuqMySiQHwBJfCwea7xUwo1YH1Wjj0OsmAA72Vg7f4QSwzm6PGgu2wxUGYbTvY+QohrOdy7m0ARU0G50P5luw+dGyJ3lQYoPbOvie6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYeQgTICJCxGAd4Wio2dTSfQioEJRqzJgm+CJejy1zA=;
 b=kwJqhMlPIx64ZjCGPOOEf0iM5ZfHY4hVO5WMfkiiMur/OG0L+/NL8wUdVmZH1EF/W1zkh7XvkDo2QKKi0k/p6vIWK3XmB4t1fBOKrxq/K2nBQ/1J4N715VFCZ0ig77VlN30bxAbIH9IISdlmmESz23rAv4YTX/eS/H1Tv6LTKVW5uedzLbvTq5UmWlvChVRQcchkiUKqiyqn7om/inkOjg90JZF/naMtuAOkWk+DWTiYfM9N73azkJKf/ZcfAGme1/yiHotO362vWtm4YCqT+r+4aoemrrlYpK4JaOdiJMP9CiOCkEjSpsK8H41XxAdWYPOi/496WzP8yk/xCMsspA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYeQgTICJCxGAd4Wio2dTSfQioEJRqzJgm+CJejy1zA=;
 b=NKEW6fOHbmb+6QvJKTyD6Jf/KUFuLk7zbMBFUePDcoT0hJCBDAf8QVe8BLgO0L7foSQ1LtITMRMIjx0CJ06ACN0nq4xGZU16Q4NwRSv39aEKkYNjXv5cKoil56G4ugcN4fAe88JH9zOT44iPigjhtfu0Y3J/ISRxdSCa4E/E5LXRQqVu0LFYDhRv+CVAClhxIJvw2ZRgm1fZAfvLOfckEma78hUO/BDi6SjJKGO2hWsIMTimqPtg7wGO7lCOARjJI5iYIK7o502w6c+vSfICsyrbwFuZJppJfHX8fzmkSq3j3mVw4rjviCvCn1+VGEA3B4UWEQfk7DJ8zzEF3P+CSg==
Received: from OS9PR01MB15202.jpnprd01.prod.outlook.com
 (2603:1096:604:3b9::10) by OS7PR01MB13701.jpnprd01.prod.outlook.com
 (2603:1096:604:359::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 02:34:14 +0000
Received: from OS9PR01MB15202.jpnprd01.prod.outlook.com
 ([fe80::bd40:1d2e:2d1f:e8f3]) by OS9PR01MB15202.jpnprd01.prod.outlook.com
 ([fe80::bd40:1d2e:2d1f:e8f3%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 02:34:13 +0000
From: Shixuan Zhao <shixuan.zhao@hotmail.com>
To: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Shixuan Zhao <shixuan.zhao@hotmail.com>
Subject: [PATCH] x86/tdx: support VM area addresses for tdx_enc_status_changed
Date: Thu, 14 Aug 2025 22:34:02 -0400
Message-ID:
 <OS9PR01MB15202A41CF04F0BBF8CE244B48D34A@OS9PR01MB15202.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0044.namprd04.prod.outlook.com
 (2603:10b6:610:77::19) To OS9PR01MB15202.jpnprd01.prod.outlook.com
 (2603:1096:604:3b9::10)
X-Microsoft-Original-Message-ID:
 <20250815023402.44631-1-shixuan.zhao@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB15202:EE_|OS7PR01MB13701:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e30bc3-72a1-41f2-f897-08dddba4390d
X-MS-Exchange-SLBlob-MailProps:
	Vs63Iqe4sQkf9IxbykVEAD9mlekdOFGXAtvHuWkotm+ga1P4LOUMNB28gmzNiwjfNOQjAb3ffoA5zLTR/MuZynstf95WSIQ9Bpdbk7gbOpMH1HajljmF3TOcnJQ35CO1z75RPpmvDMCIYTCVaq1mUNX+fDHb29acRO2RJO1rBJ/GFqzxSxRk+M0Rs1mDAJ9Q96ee/zGscBTMOnIeGztoLz/uJDa24ceb8Pnh/OZRXNVC4RSpCtWqH+drlr+LFgnxDO1M+9FdGYeD01kwX791NiXk1qJIQAsYYc3FS3i91z2h1qeHcFZGA3jwsAXlAV46D5YR5GaPMYyxS0x3yAf3qTOuv9oYFbPoI0KsyDc5Fi2PC7FxdAkKxExQNOotgFM5N7KWEKDOaZvIyi5d4bB8TQw8lL5ycAc39QHhvcZHh00FIWkBdY1jEWE2OpDTc6PSuA4mBSaUpvkFZ9SsqrgyD6QwF8qHQaiEV7ncwKe1f0V4MIsdvXl3X/nD2BS3A4k0raDbaSnFOsAYYqoPK9Vb51t2d03VMDBg7ArycdXopVJ63Ql+lDyMtyxEFxCONBooK7jRv3S1AQglqC/BtfMwXQtzwFrsK/SC71FH0nKTXcQONyVFn02raTn2TyIhr3tdlhJmd9vN2EVLxfsqQ7V27u8v6064pSd9b4v2M3/1/qnjdQRDn0malwGpGkTrfvG5yM2LtpPIRsJXvXwMKFnNF9xNslXnmjVVdLZg7qGKOX0=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|15080799012|8060799015|19110799012|461199028|41001999006|5072599009|5062599005|13041999003|3412199025|39105399003|40105399003|440099028|12091999003|26104999006|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pIoQNUOvtAjiEi/aQLUtD107nHuYyfKyXXoYBFc1e23LrAu4K+vYUwBXZCEh?=
 =?us-ascii?Q?cNg4sRx/VFpwYzMPcgJIIedTHcAgOUD3ZlwcTmyBjRMExMECyOszdqhphIhb?=
 =?us-ascii?Q?QokNEJPgXFi2CdiRpARo7z44M5DlV981ECjJAodE8M/KARBx7/jsOJ7FQ93e?=
 =?us-ascii?Q?nR6W4VHUzBS3zGgxdc9usb9oj3G997nTLZxygYKRKfAKGkbJjg4RtENcsAlx?=
 =?us-ascii?Q?SkrLZrgJBfs5yYmbdemzinuYlRonWpyhqcwJ+BKIavibBdUpB6NfCS2h38Gu?=
 =?us-ascii?Q?4DQVW11yO3MCRChlJpU4G4/tgLA0QE3nBgijMx7X0di48ZoJYnBSXo1UTcco?=
 =?us-ascii?Q?S+a4Tb1C6F7tWlhHc90bo/PtJv6qjR+8/Y1nuKTXCvRYiqzKpYv2aV0mqdkg?=
 =?us-ascii?Q?F+9rUBiIdoET90SX8vR4QDWvzr/eMUvGPlC2u1y7gaOOWq1fAmbLlTPhOwlC?=
 =?us-ascii?Q?cDrN57baB4W7XMJ4ChOyeIc3ApJIDNRze1ukSeX1N3zlJiAyzntiESuF8fKB?=
 =?us-ascii?Q?IsDBrXc9W4InrrV3M1qArxRrwYWn4/tQgyxl47FOraWr8BUR/+yLxMcGfqWb?=
 =?us-ascii?Q?aW5HGwhf6XJySsLsJm0b3Yk4SgzZ8HzmW4Z3c8sQqyw0eDUDpRFUWyMSAn1Y?=
 =?us-ascii?Q?+pYa6Ebr+TKCH0pRT8ZpZ4lo7UZ7RaPDxOBvtorixCtgiFYwBFIeDN78BlLj?=
 =?us-ascii?Q?1ECzCx5hfMFJJNxHZ5dcqp4UfGauXREBSzWu4e2PiLK/DYUWxGfsLC1gp4zY?=
 =?us-ascii?Q?euRWPbsCPqW082TO3vvPR3U8kiCInOMZwBI/hGjHl1YKvH55/U0onjVoQeo2?=
 =?us-ascii?Q?1ovdjrD6wXaLjRouJYU2IXSYT6lYEIHd3AujV+q7UqFPkJ5OOgnTNOO30kMP?=
 =?us-ascii?Q?3+e0OLl4dCVKwuSpks2juwnCN+zKxDWom9Mk8Or+7E1CiUuK9HyApwqe9N0b?=
 =?us-ascii?Q?j2dmLg9fEMmfEo10Lth7P8Loq4xUpYFDFtcr0fZiCXZ6riCc7LMfPbZqmvI8?=
 =?us-ascii?Q?JUX7D1PxxsKIqNjYGFA7QgvPLpCsmZ78CqomddBxu1ivNHneIoovVlflJdt/?=
 =?us-ascii?Q?V+CVUD0DoZPJAJociNZQEZxFaLPHlh0Hc6ZkMMMwXGfhlXuzhUs47eBzVBS7?=
 =?us-ascii?Q?61gWwACEOWRpAqJMY4FnzO58Xp1vE7f0D4kpcxMJxdF2VRUfpGgYIpsI4TlZ?=
 =?us-ascii?Q?/wSBU0wFcFrd3J9TbWTONVIl3+YirWU/BUFwKl8dJdbXrf2bkDMl71yiwKw5?=
 =?us-ascii?Q?Q083Tr5O0VrLxgVw/cJL5ItUL3PvW1m7F2Sjg/L2w0HdUtc3jbh/JgkM/Sem?=
 =?us-ascii?Q?qQZBgMlgEAxRWQIq9S7eerw301OfhhnjBRHMD/jEA85FSu41V+DsUsBVPtoG?=
 =?us-ascii?Q?aaHV//E=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e5fdM3cWJZPA4rIdFL6FtSzZvZyCcFG1MfAjVeK/ZihZBMt83erZ4gz72Oxy?=
 =?us-ascii?Q?zkgI5zJ6RNev6dCZVGxl3HdoENfWCXBWGuCijLoxjRlvxPROKgjImT4cvKhb?=
 =?us-ascii?Q?xg4z7wvzhSYfhuMdLHjaWFP4NW4rkALsYAcv2HSJT9xdRtAJ8uKOKHcYrVf8?=
 =?us-ascii?Q?/XO7lV31kkNADhJ1Z1m2ubxX+cP9d2hpwrQt+DIZSB+6HGYb3mpeSrRnQ+2B?=
 =?us-ascii?Q?kYbYteufDfCTUj8zEgXTXYjadfEKvrvk3a3YoMNYX6GAtzHFfpmU/cAym/RU?=
 =?us-ascii?Q?3gvqPWv7GmWzWTs0Rj2CJepkj7pnUg0TfT8tjjaoHOCt8oQ8Qv3RUtTvkmUP?=
 =?us-ascii?Q?PPevNjATfH5c1yMJpnNohGLQId3a1DlFPMysaDZGwNf2GrwMAxyViqWzkZuo?=
 =?us-ascii?Q?gGa/b7as3rBBNTK5QPB8yJP5IdKLsTbzy+awHQgS5wlxknyDqIh253eBdusU?=
 =?us-ascii?Q?CXHWhbScxtMk1vTQ7QsiA7kTICtx7SR0Lt7MmexlxSLl3x08VbAWMIATbA1m?=
 =?us-ascii?Q?oZPup06M7IuHQs1q+YKaCMdu2bwiNzXxyp0d4t1wjywLwGa4bdPLCMwbdB6l?=
 =?us-ascii?Q?arcs1jy3jhwOEfy/epjudAh5UdaZOeTWERiGw3n95XEkrRLN0NVvSX14hrxh?=
 =?us-ascii?Q?5PQCEGhfD+1cPY5B+7rGmspIUXHJ96j4KCjHw/6uNO9lEV15MbLJ2hkK1me0?=
 =?us-ascii?Q?K24fmPMAOUjKl30YmECvoIcVsvX6SzJbYD4z2CiR+9aLuH0tC0r1m+y/Oh/8?=
 =?us-ascii?Q?ruBdtgr/RA7OIh1PKtyV7UaonoVazBHmDgGKqVYrjIavHa/oVHsjglpmvmnK?=
 =?us-ascii?Q?PCfIgSilKolcMsqPOt1gpC8Xe3TxQ2TN6tIkF5pUH2ao0yi8sZcLAu3WsLxW?=
 =?us-ascii?Q?HLJCk7SxEMI2uu/dqltOUO8UcD7JJNaEaP/fYRgv+GUs63HtMBffXhjtgG6o?=
 =?us-ascii?Q?g/blSkV5ozi4hjxVBUUQFcGc5BrvJy7TVYTYQOfQggy3bLvxXp6G/VpkMhGy?=
 =?us-ascii?Q?hIJEAeAeKXWAElIbh9vMHmGOEws4Cuha2QSw9YB3HRFhXzpbyRUtRnnEzplI?=
 =?us-ascii?Q?BDuNDReTrB7o9eAC9jcB1+4yd2YC9VcW6CWPitTgZN1onhkjNWSNC9wdlpBI?=
 =?us-ascii?Q?44GMYKloPtFJlsCbZlf+nwLbjlpy8GRrdfCaOBexWpbXuL5CccmbY3UOoBPH?=
 =?us-ascii?Q?IxETiI65ErLlqUX3FXc5toaGjSyAzAVgfbj3pMFvdkDQt+HnlXUWJPcFUlbj?=
 =?us-ascii?Q?KzkyJBuz5NCmVGFg7pQKO1TKVisTIHZiAjjfjw8cc88cB0H1Rby1iJZzuKrK?=
 =?us-ascii?Q?2giUKw1J1bNj3CyKkrh6NAPf?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-9a502.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e30bc3-72a1-41f2-f897-08dddba4390d
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB15202.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:34:13.9199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13701

Currently tdx_enc_status_changed uses __pa which will only accept
addresses within the linear mapping. This patch allows memory allocated
in the VM area to be used.

For VM area addresses, we do it page-by-page since there's no guarantee
that the physical pages are contiguous. If, however, the entire range
falls within the linear mapping, we provide a fast path that do the
entire range just like the current version so that the performance
would remain roughly the same as current.

Signed-off-by: Shixuan Zhao <shixuan.zhao@hotmail.com>
---
Hi,

I recently ran into a problem where tdx_enc_status_changed was not
implemented to handle memory mapped in the kernel VM area (e.g., ioremap
or vmalloc). I have created a patch that tries to fix this problem. The
overall idea is to keep a fast path for the current __pa-based routine
if the range falls within the linear mapping, otherwise fall to a page-by-
page page table walk for those in the VM area.

It's the first time I'm submitting a patch to the kernel so although I've
done the RTFM, feel free to discuss or point out anything improper.

Thanks,
Shixuan

 arch/x86/coco/tdx/tdx.c | 42 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 7b2833705..c56cd429f 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -957,15 +957,11 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
 }
 
 /*
- * Inform the VMM of the guest's intent for this physical page: shared with
- * the VMM or private to the guest.  The VMM is expected to change its mapping
- * of the page in response.
+ * Helper that works on a paddr range for tdx_enc_status_changed
  */
-static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
+static bool tdx_enc_status_changed_phys(phys_addr_t start, phys_addr_t end,
+					bool enc)
 {
-	phys_addr_t start = __pa(vaddr);
-	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
-
 	if (!tdx_map_gpa(start, end, enc))
 		return false;
 
@@ -976,6 +972,38 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 	return true;
 }
 
+/*
+ * Inform the VMM of the guest's intent for this vaddr range: shared with
+ * the VMM or private to the guest.  The VMM is expected to change its mapping
+ * of the page in response.
+ */
+static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
+{
+	unsigned long va_iter;
+	unsigned long end_va = vaddr + numpages * PAGE_SIZE;
+	phys_addr_t start_pa, end_pa;
+
+	/* fast path when the entire range is within linear mapping */
+	if (virt_addr_valid((void *)vaddr) &&
+	    virt_addr_valid((void *)end_va)) {
+		start_pa = __pa(vaddr);
+		end_pa = __pa(end_va);
+
+		return tdx_enc_status_changed_phys(start_pa, end_pa, enc);
+	}
+
+	/* use page table walk for memory in VM area */
+	for (va_iter = vaddr; va_iter < end_va; va_iter += PAGE_SIZE) {
+		start_pa = slow_virt_to_phys((void *)va_iter);
+		end_pa = start_pa + PAGE_SIZE;
+
+		if (!tdx_enc_status_changed_phys(start_pa, end_pa, enc))
+			return false;
+	}
+
+	return true;
+}
+
 static int tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
 					 bool enc)
 {
-- 
2.43.0


