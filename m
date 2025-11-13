Return-Path: <linux-kernel+bounces-899267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B6EC573D8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4BE84E400F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292AA33556C;
	Thu, 13 Nov 2025 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RXNe7ZuD"
Received: from sonic315-33.consmr.mail.gq1.yahoo.com (sonic315-33.consmr.mail.gq1.yahoo.com [98.137.65.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853C9257841
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 11:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.65.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034107; cv=none; b=pujKmJ4VQIH6lU1SORPudCXN9t7Rh3zuNztsxBPtPHYylFMd/W67+JFSXKMbPi8Jrfs5oH5B3Yl2z60bIkbGqdTp3V1sd1jgR73ov5VARd91TQTFZBu75qBO6/F4fG5zibZu3hFSUgLPRBx5FT272n3TrFiHaTngkM9yFK41y2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034107; c=relaxed/simple;
	bh=SZalB5aQla3qn/0cW/BbnXxJUbwl6RPd2pzE9G6eyxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=Ya1Sq8wQecgdkFsVa3vgAtOzlQc+mB8RgksY3utLs7nndSbHCSporIeRfyCbhpPbHVxi60/9Xq+MQjaAmYnKoe0gHxoIibxzCRs6OHf43KFshIZN1OP5KvuSnQDP360hAcnlBich+BbVMl1FrCDVKmiaLKMCnwHxAsJaaySbhq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=RXNe7ZuD; arc=none smtp.client-ip=98.137.65.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763034104; bh=oT4L3jIxsTZnsFboLQQ8v8h33s4X0AFwU2A0o+fUlg4=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=RXNe7ZuDb2HV7lak69c9qyQuvhiuAyY9erolTPl9eJuTm7CUAVgLkZfK+juyLSZyisRSPni+7hE7CmlvOM87BWQ/MDXQTYb0RefAQPe2voU5YGNdb+yx8Ke/pXLW7XuGrbavSMq+6wF5hleJlFBL5KIpCWCJ0sdobqcyOa3NIsgcIerBVKzB9+9zUip5t+8Dp1F3FE37xLwTdK2pG6Q1HQJQwEbS7hSYwkq2rJXSLxI9ozN1WGv8ChgNbOJIMoyQPncYWhDv+9oHsKLF7FZnMm3mRJR0EiN2DlOF6QzCfpVZCQnWkPqcLVakHDdTzL0zVlM2+1HmtrSU/0pvIiNt1g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763034104; bh=Lh4xgIe48PyE/JQ5xtt1U44NYTvAHfNeEri1tlTptBB=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=LNqZwKWrgTIl8FF/mopPVYU4CeRA0qx7vFcqkZeGq4B6qVeFtkwAdVvQMyb/H/1QH1DUWxeOX0YBJoMlXbj/oXRRq3HZU7cVx/RaI8IVtHFhIzR4kcLrOjvt7UIbkzeZZv9k1Uznck30rOKM+2P3eylYPAa5YkQMEjUJ8K8P4Zmh/OB/4yJuVVTdK4uIX+zJRJZLVLibG0fmOIWimGe9U8Qzgd2nmp+BJYWeWGHAam2dpRMFBOqvkUTjbBNJmsPj5gMTmC4YU8o0fjPt+UbztGk2IeyCoCs+YXGbWg6bLsb3mXdKk+FYNZ6W8+sdwuG7aONVdeIzknLbC3YQ01sTLg==
X-YMail-OSG: AWsnZJUVM1kklOsVl7Rrkc5i8tP2_uXsAz4OER_Q1f4tfunrRAKx18IaT14JiR5
 1ZXWCSnzy7iYsRGMgFIMXjcJV52.5vJtJoyHAklxyecnltOwAwvMwVJOpdo.pAe6_1gyZ6gEzvIi
 zJLUYAM2gMED3wygyTHe6Bgp3ryBGN9d_vBrK7tpm4d8qxnTrEcKkmFNRZVuDrq.Ben1V0pO27GL
 jwdmR.Y7x115ORbaSQF0n6rc6CVcFTyGqJcUpxfoPXnYrFf2i7vmX5cLQK9Vw67H0csPSs.wEj53
 wsFAp2nyLvNZwCe1u0KeM4LN5K.D7.hMa790XstnVFGNJOxhcT9GD44jphWCQ7iqaItvQ9lNbrsn
 6VqZvdicNtja936BcLSQsoPuaLeBM8fM_N5dXrycn3xlYMzuk_OhI2bm3moiV6LeJeKRiPY9wUPj
 fMOnEu.Lg4X3S1NIHfhlyNwpNzQBACZDc0flym.BWyxKk2kpu2EHpHiCYK6mvEkGNgDx0NwLzDoT
 .pJBqzH1DV9EfFLMHyo5ao68CKYLMv.gJopwQDYdsXu1MHeuyaInw_U1h779HoXiO_aaQiGbUpAx
 DJ.sqCboWFkjiFEtwaNm4P6CzeNR3c52kRWCLUZAydRZ6MK.LlJS_TAvOz.06YdiARqtfh1bc2Tg
 i9DNT.TTnYHIKxnLdLXVYnYTnmR2Nwhjs22O_dskpUcZr9QI010QUJ28G9777GXIXbTdtH2p5ba0
 oz84Ddz6qmt7Kdxr7WbRhnXlQRjlJ7H0PlgLA5bkjCvMIhWQ3YMBLte4pkTtjsrq9HIDuM0yNUX2
 VZ2PXUAG3KYUY3riUJKmut2.ZmWbdkR.JYPaMcyR.JjP9hZvjGQqcf0NXAxG5vBPi.D2Lx6VA1mn
 tcVdlyY08dsodSB7eI5iqsklHMsXoW.tYSgNJOlZ71mbyauHggsvKzSskem0oc33HMLWmS7tz97d
 uLsA8UOth_2ex.CUzRqLfz7e2VobsiR_y0oT3WBzeuQZOsSOJKU8ABBw4RudxGtYkunAYKpMJ_Zr
 42zetxB_nWgr673nHIh9VwgVt1vCVb2h9om2N4PvswJolDAoKkzy1XAHPqV2p2mT.7NQxIVFZou6
 9V7TCcWxmAb1Ct4nKVUzuGuCe.2VxjDLXf41yGdIeFBTSIyjdQIA3qrq.AGDPBQf7BCo9CE7XF4e
 XXaIwm3zM0S0bJPdCisFupjL5ueG924NqYesIZtk8xplY6mQfHXEOEVolLrODhUYlfGc7XYlFlQM
 7rXNHn.iZWJ3hIO94kzxHw4YpsXyoTjzLPd9XBhjpG8ov5_vPCF5uoWpPIKvg7JJvllCfXlkNBOH
 LhRv_Rp3ygE0p1HrnOkwAJYVZj0G4u.LwN8cd7_nEzfYBbCh8f4dEceNmKeMgMqiSZg2jUKrC7zH
 naipx22fPVjf01HtFFpujLjMKr3_J3Er7HrqG_0lUFgY14JrBikdRnqu3oUmbjLDdCMW754jR3b2
 2FIoSW3DAcbzQ6A3l3BS3UXnLcgUdsN1hdAEPdLjaUAEVSZuoElBqbvaB35a0f6kL3oD7WPa18c3
 1n233sZCNRto5il4zT_QZSa6oj68Le194xGV2t1Z9xA0LtMGvENGquucDprSwC33CpJynaDF6XV_
 lYHxgkNccj74NvP1JPfW2L2b9iP4AWMunVw_xWfgTPOGh9e9navjKZDh9EKzJx7WvaL5OdurXTPm
 OL6fMQZlFW7g21Y8TWcVPSWmIckjDZlRK3k.Ix78TLYiORQBhQ267f8CIAC966R0uA7ilFaya_bF
 WmNFT7GcwSckhgjKFaMwmD85r3e2cPsivjICGWjGIWrsQjlhrBahUemKjbbNUPkahxcFT5cLZcky
 CNmqHakTTqNfVujC8_HdkIRHYVnvaffyknLXSGu68iiMig7MTK01Ly.ophJ4jYNm9Fjf_sTGc0f3
 lxBe_yY6FL6egiqSJF0x_URDgd32JiHaKbJ6d0hU.pasK1w0.WOKHtdnqDBpjL77Ag6KE3kqTbWI
 j2866qbJSPHvXP2CQFsQ7DkcHiQ95DhqsRcpsMDtyg2X1WSe.rtud9QAk1gk36hFfr7D4R3I.G7K
 IZDVFjceFj0gM_SAt0AUBCwA_jSTg6ubBR_8Z_090KPgePdcHOjj75zq54y.NZdR8_Ppp6OCRIps
 XwvrF3g176.1INHnDyuVdj5tQUm2BQCojjHqeTfqbMqtEK7G9EozprmRL4_9r0GqZkYl7p0S5nGA
 LdCyrxKa6kJBjTp9BPk.XizOnQsq4TGtS0NY0PXI_YbcoPWB_yiGTA_LpRh6Jyx6n4rLj.LxuBOf
 tCgVr97crLm5AcatB6RBwUBsVEMivXEoGzTsa.AXhRPVncxSNwmmH98kYSLSNAHtDGHxfStSPjxV
 6DpEKyEGF8Ljf2L5S
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: 5093b66e-f2ca-464a-916b-91760f641faf
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 13 Nov 2025 11:41:44 +0000
Received: by hermes--production-bf1-58477f5468-b4rj2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d8fb56c506b501dc7b51dd0946a4f9cb;
          Thu, 13 Nov 2025 11:09:20 +0000 (UTC)
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Subject: [PATCH v2] power: swap: Convert kernel-doc comments to regular block comments
Date: Thu, 13 Nov 2025 12:09:14 +0100
Message-ID: <20251113110914.44223-1-adelodunolaoluwa@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20251113110914.44223-1-adelodunolaoluwa.ref@yahoo.com>

Several static functions in kernel/power/swap.c were using the kernel-doc
comment style (/** ... */) even though they are not exported or referenced
in generated documentation. This triggers documentation warnings and makes
the comments inconsistent with kernel style for local functions.

Convert these comment blocks to regular C-style comments (/* ... */) and
update a few function headers to include proper "Return:" descriptions
where applicable.

No functional changes.

Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
---
changelog:

changes from v1 to v2:
- Converted function comment blocks from /** */ to /* */ style for
  static functions
- Minor reformatting of comment indentation and spacing

v1 patch link:
https://lore.kernel.org/all/20251106113938.34693-2-adelodunolaoluwa@yahoo.com/

 kernel/power/swap.c | 54 ++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 0beff7eeaaba..076ed590e8c9 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -336,10 +336,8 @@ static int mark_swapfiles(struct swap_map_handle *handle, unsigned int flags)
  */
 unsigned int swsusp_header_flags;
 
-/**
- *	swsusp_swap_check - check if the resume device is a swap device
- *	and get its index (if so)
- *
+/*
+ *	check if the resume device is a swap device and get its index (if so).
  *	This is called before saving image
  */
 static int swsusp_swap_check(void)
@@ -362,11 +360,8 @@ static int swsusp_swap_check(void)
 	return 0;
 }
 
-/**
- *	write_page - Write one page to given swap location.
- *	@buf:		Address we're writing.
- *	@offset:	Offset of the swap page we're writing to.
- *	@hb:		bio completion batch
+/*
+ *	Write one page to given swap location.
  */
 
 static int write_page(void *buf, sector_t offset, struct hib_bio_batch *hb)
@@ -526,8 +521,8 @@ static int swap_writer_finish(struct swap_map_handle *handle,
 #define CMP_MIN_RD_PAGES	1024
 #define CMP_MAX_RD_PAGES	8192
 
-/**
- *	save_image - save the suspend image data
+/*
+ *	save the suspend image data
  */
 
 static int save_image(struct swap_map_handle *handle,
@@ -671,11 +666,8 @@ static int compress_threadfn(void *data)
 	return 0;
 }
 
-/**
- * save_compressed_image - Save the suspend image data after compression.
- * @handle: Swap map handle to use for saving the image.
- * @snapshot: Image to read data from.
- * @nr_to_write: Number of pages to save.
+/*
+ * Save the suspend image data after compression.
  */
 static int save_compressed_image(struct swap_map_handle *handle,
 				 struct snapshot_handle *snapshot,
@@ -904,11 +896,8 @@ static int save_compressed_image(struct swap_map_handle *handle,
 	return ret;
 }
 
-/**
- *	enough_swap - Make sure we have enough swap to save the image.
- *
- *	Returns TRUE or FALSE after checking the total amount of swap
- *	space available from the resume partition.
+/*
+ *	Make sure we have enough swap to save the image.
  */
 
 static int enough_swap(unsigned int nr_pages)
@@ -930,6 +919,8 @@ static int enough_swap(unsigned int nr_pages)
  *	them synced (in case something goes wrong) but we DO not want to mark
  *	filesystem clean: it is not. (And it does not matter, if we resume
  *	correctly, we'll mark system clean, anyway.)
+ *
+ *	Return: 0 on success, negative error code on failure.
  */
 
 int swsusp_write(unsigned int flags)
@@ -1077,10 +1068,8 @@ static int swap_reader_finish(struct swap_map_handle *handle)
 	return 0;
 }
 
-/**
- *	load_image - load the image using the swap map handle
- *	@handle and the snapshot handle @snapshot
- *	(assume there are @nr_pages pages to load)
+/*
+ *	load the image using the swap map handle
  */
 
 static int load_image(struct swap_map_handle *handle,
@@ -1190,11 +1179,8 @@ static int decompress_threadfn(void *data)
 	return 0;
 }
 
-/**
- * load_compressed_image - Load compressed image data and decompress it.
- * @handle: Swap map handle to use for loading data.
- * @snapshot: Image to copy uncompressed data into.
- * @nr_to_read: Number of pages to load.
+/*
+ * Load compressed image data and decompress it.
  */
 static int load_compressed_image(struct swap_map_handle *handle,
 				 struct snapshot_handle *snapshot,
@@ -1529,6 +1515,8 @@ static int load_compressed_image(struct swap_map_handle *handle,
  *	swsusp_read - read the hibernation image.
  *	@flags_p: flags passed by the "frozen" kernel in the image header should
  *		  be written into this memory location
+ *
+ *	Return: 0 on success, negative error code on failure.
  */
 
 int swsusp_read(unsigned int *flags_p)
@@ -1567,6 +1555,10 @@ static void *swsusp_holder;
 /**
  * swsusp_check - Open the resume device and check for the swsusp signature.
  * @exclusive: Open the resume device exclusively.
+ *
+ * Return:
+ *	0 if a valid hibernation image is found,
+ *	negative error code on failure.
  */
 
 int swsusp_check(bool exclusive)
@@ -1631,6 +1623,8 @@ void swsusp_close(void)
 
 /**
  *      swsusp_unmark - Unmark swsusp signature in the resume device
+ *
+ *      Return: 0 on success, negative error code on failure.
  */
 
 #ifdef CONFIG_SUSPEND
-- 
2.43.0


