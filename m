Return-Path: <linux-kernel+bounces-882861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BFBC2BB91
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 424894F38D7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E16B30CD9E;
	Mon,  3 Nov 2025 12:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBini41k"
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D065A3081BA
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173228; cv=none; b=ONW0iseNPqr90sTV+lyPwuMSGr03S5O8aOm6TdAhhL/f9K1dxLnWqm+CjP/yUXqO1Q7P0dX+OWHhKoi9wgMN7uVZH6Z79SZPezTNPBKNSlMVIZAitcVuFJiWi3Se7F/SNvbBHQXL7nD7LWweC4iW4XXL4HASDSabKZyi2Un0DJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173228; c=relaxed/simple;
	bh=ghhidARFtfJugeCzCLtclN3YKp1i6H9G6hYai1TD4Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dlb2xvn/kuUscxUtPDXptSU7I+BVCxW0JvQ1jg9fkRx7VHYeSSejw4ZGj5MI1EPIY57PMa3FiKvpbN5nJhMiBy30XUnLdrb8R5+ofTk4u5PIoFAoxl4zdIaQnysglC2MnArHox4KbCQAECYjUeErmKXOod8/cNaqnLxVLv9rVOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBini41k; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-429b7ba208eso2592222f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 04:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762173225; x=1762778025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jwjU3G+SlHqEQOLDInlGvFRjuKuVcl3NjbYL1KLyrdk=;
        b=QBini41k048D6HXSU+5w1dC87BT5zFry+1MIOSgcuJLirxaeJLSAtHl966Gro7FzRf
         ALWmUB1kjm6QULdsHwn4HsWPyEiZQD1Z0TqGiqLnw5u4+9CDYRnyp349C2Ds7ripC7ZB
         Jj8cokWXjZwnYo0IFZ+s/1Ty0dmktX7WZwj4pttlP3bXXogvvzYaewV+hlGytAnpJSMT
         yp3DZ079o0hKef1SIiokvZt/u8tcyAdITPqR3EOXNd7itbAsmhB8bIVNV4YF2riUi2OE
         LL6OLd8hIqHRl8zjRbM2z4MJO5UkJAPmM7nfSwXC/vSBDASQ8FHm+toa7L11YDVKLvH8
         x6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762173225; x=1762778025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwjU3G+SlHqEQOLDInlGvFRjuKuVcl3NjbYL1KLyrdk=;
        b=FuU+y+H1/VzLhdmIOFh0sZWQ3KTQvZXI+opMVdyQnq1SRflQJasJpifmg/pu2ziGTC
         4F4pJoT2omULzg3K9cR75q907m5x8Qsn0NuOo7XofAdLJJ4zqtlN/vVejMHCStwZOfkd
         hWuqBQa1ZRLGAnpDOy+LfrIvXC6ENIIA638Iu6j8dSFoBApg6Pi8GpGM0OZ3p1ObycMl
         KKmZtzJL5Priv3C+TEkVSxzpdcmkLoP92CoUksqp8TbgK70GrpQYmnOFVx0/cvm7mwiZ
         ppFywPqjJtoesd/1SVssRAEPMshzxLI+6yXzSF65o2gl1qs5ke/qjQzZp33TqrF4/3cE
         8xww==
X-Forwarded-Encrypted: i=1; AJvYcCWoFDwBrsPjejg2m4+y2GTbSopRWzjLgubuVZUCEFJclHrlODXQwUSbUufkiCX7PQdUXullsgUAZcEh6YY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz6CCzw/8gZndfJU/tjC4iSwW1n0f8O4Ua8bJKhGqsC9nakTuA
	0ClEMXrfpOhjkvRL9eH/xh5+cAqlmboIoseNAo8qaDl8FIpRT4QJdX3QtR5WqlBp8RZHkg==
X-Gm-Gg: ASbGncvCT0NME8DH9Mvo72xaRmj5iyoUtF58AoeMKpELVqMo8W0zzEc1xDvf0pAPttu
	XCz9Jc/otggh/FnW80EIv7BuJxWWvSAc5VAQNyW3vRTHaRT5HgLTL4OWVK7NS7NvhCXh9Gmq48b
	+zYekCmzs7IZJn4uC6rJuWgBbegCXALxZpf/fGs4YFYAKDryNTKvFBh5bqyhLgz0/EslVTCHEN1
	PnI8XNwDOBaa1oJeXABPIWcJx1BIAxvWDLp51PRAe65G6Wn8eljnysk75KNXVh/j7IBtKSFXNsm
	lpMtIrJAOSYxDQ01zCLKkhPe71LSNrTOo8aBQin/HGfeTBg/UI5lrWAU/WZhxkw+lGI+4JnmQfo
	UKrCjxWYieteTCoREkPQp1U2BM25YMdZcJ4ch46y4nVaUZEHf2lmGpaLMa4Al0MEV8LnqEb6Kj2
	fa6nRFp6/JKifEWyQ2dp6b29FCXKKLapKCnufyTCqbPEBlM83gF7HmIKkZj1zOQClVF/5SSno//
	Vg=
X-Google-Smtp-Source: AGHT+IEwV7DamHH8yuNQtr/2Vcl0mNBkIWyq3ZNNbW0+a4hs/HLsXuOao7LPKAznJr3kDLofhaikAA==
X-Received: by 2002:a05:6000:2f88:b0:429:bb53:c8f4 with SMTP id ffacd0b85a97d-429bd6a4bd3mr8480044f8f.34.1762173225005;
        Mon, 03 Nov 2025 04:33:45 -0800 (PST)
Received: from workstation.vpn.francesco.cc (ip7-114-231-195.pool-bba.aruba.it. [195.231.114.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13f32edsm19673346f8f.41.2025.11.03.04.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 04:33:44 -0800 (PST)
From: Francesco Pompo <francescopompo2@gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Pompo <francescopompo2@gmail.com>
Subject: [PATCH v2] efistub/x86: Add fallback for SMBIOS record lookup
Date: Mon,  3 Nov 2025 13:25:39 +0100
Message-ID: <20251103123335.1089483-1-francescopompo2@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Apple EFI firmwares do not provide the SMBIOS Protocol,
causing efi_get_smbios_record() to fail. This prevents retrieval of
system information such as product name, which is needed by
apple_set_os() to enable the integrated GPU on dual-graphics Intel
MacBooks.

Add a fallback that directly parses the SMBIOS entry point table when
the protocol is unavailable.

Signed-off-by: Francesco Pompo <francescopompo2@gmail.com>
---
 drivers/firmware/efi/libstub/x86-stub.c | 107 +++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index f8e465da344d..13059412fdb9 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -225,6 +225,110 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 	}
 }
 
+struct smbios_entry_point {
+	char anchor[4];
+	u8 ep_checksum;
+	u8 ep_length;
+	u8 major_version;
+	u8 minor_version;
+	u16 max_size_entry;
+	u8 ep_rev;
+	u8 reserved[5];
+	char int_anchor[5];
+	u8 int_checksum;
+	u16 st_length;
+	u32 st_address;
+	u16 number_of_entries;
+	u8 bcd_rev;
+};
+
+static bool verify_ep_checksum(const struct smbios_entry_point *ep)
+{
+	const u8 *ptr = (u8 *)ep;
+	u8 sum = 0;
+	int i;
+
+	for (i = 0; i < ep->ep_length; i++)
+		sum += ptr[i];
+
+	return sum == 0;
+}
+
+static bool verify_ep_int_checksum(const struct smbios_entry_point *ep)
+{
+	const u8 *ptr = (u8 *)&ep->int_anchor;
+	u8 sum = 0;
+	int i;
+
+	for (i = 0; i < 15; i++)
+		sum += ptr[i];
+
+	return sum == 0;
+}
+
+static bool verify_ep_integrity(const struct smbios_entry_point *ep)
+{
+	if (memcmp(ep->anchor, "_SM_", sizeof(ep->anchor)) != 0)
+		return false;
+
+	if (memcmp(ep->int_anchor, "_DMI_", sizeof(ep->int_anchor)) != 0)
+		return false;
+
+	if (!verify_ep_checksum(ep) || !verify_ep_int_checksum(ep))
+		return false;
+
+	return true;
+}
+
+static const struct efi_smbios_record *search_record(void *table, u32 length,
+						     u8 type)
+{
+	const u8 *p, *end;
+
+	p = (u8 *)table;
+	end = p + length;
+
+	while (p + sizeof(struct efi_smbios_record) < end) {
+		const struct efi_smbios_record *hdr =
+			(struct efi_smbios_record *)p;
+		const u8 *next;
+
+		if (hdr->type == type)
+			return hdr;
+
+		/* Type 127 = End-of-Table */
+		if (hdr->type == 0x7F)
+			return NULL;
+
+		/* Jumping to the unformed section */
+		next = p + hdr->length;
+
+		/* Unformed section ends with 0000h */
+		while ((next[0] != 0 || next[1] != 0) && next + 1 < end)
+			next++;
+
+		next += 2;
+		p = next;
+	}
+
+	return NULL;
+}
+
+static const struct efi_smbios_record *get_table_record(u8 type)
+{
+	const struct smbios_entry_point *ep;
+
+	ep = get_efi_config_table(SMBIOS_TABLE_GUID);
+	if (!ep)
+		return NULL;
+
+	if (!verify_ep_integrity(ep))
+		return NULL;
+
+	return search_record((void *)(unsigned long)ep->st_address,
+		ep->st_length, type);
+}
+
 static bool apple_match_product_name(void)
 {
 	static const char type1_product_matches[][15] = {
@@ -240,7 +344,8 @@ static bool apple_match_product_name(void)
 	const struct efi_smbios_type1_record *record;
 	const u8 *product;
 
-	record = (struct efi_smbios_type1_record *)efi_get_smbios_record(1);
+	record = (struct efi_smbios_type1_record *)(efi_get_smbios_record(1) ?:
+		get_table_record(1));
 	if (!record)
 		return false;
 
-- 
2.50.1


