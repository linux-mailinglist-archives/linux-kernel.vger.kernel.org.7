Return-Path: <linux-kernel+bounces-711703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FD4AEFE3D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 17:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D734160FBB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 15:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDC227A93F;
	Tue,  1 Jul 2025 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="LTdE5sAA"
Received: from outbound.pv.icloud.com (p-west1-cluster1-host5-snip4-2.eps.apple.com [57.103.64.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFD127B4E8
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383568; cv=none; b=lIlKHawL1ZndGeTyBq+6OA3eoR75oob0X0aXMIEtIevu0ksGRVFJamIwZRO5ZF/LdJwEQ34wes/vlzE1AvSE+dknSjf+YoUMbGcTXgm2a1Cf1H9IulpTgHZfdUGSv/trAzHm0YULN/qy2dqH/coKm/ATFvxZtsvdBiqc/Bwpofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383568; c=relaxed/simple;
	bh=Ok9kSbMDFPxfjgp+tCUuLco8hQJX0O2RZsCns84yi7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oTbmgbaYiNoD4yr5weub3z57RJIuogvAA3BXos2WijHn+/Xg8bpgwG2t9UR+Prv0GLFlZ+x5EgN35stp1tz9HlvwMK4qbntyEeyCF5PJ0E18Al09bU3suhWXzRu58vrozBseVYgONBYI3hvQ1bMoeqfJ3BXPg1xyD9ekHNhZVKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=LTdE5sAA; arc=none smtp.client-ip=57.103.64.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=F3ra+DeWxuG4yVJc/9GY0kCZWTzvUo78nZmUtQ8n4t0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=LTdE5sAAElS5WeI3dorrVvQs8WewSQkeBGVS/ZVMsNzPed0Ly2OearfYym6nP7r6P
	 KoKE9iuIj+rSVjS8B2cT9YR9OWbX2FuBV25z2pJhYQaUPGkFdoIGcEK6HCHv9I35zQ
	 lak/m8fBZp1G2tzhgEfkOZDKBdyVQwqRODBLzuJMujgKN+ZiVo4N0AxAiyCh0HJcWD
	 Y5Bo5oBHT1R9dx5pkEtcb4jra8jo/pA2GKtW6oqYuWvZZ9PF0t/m+ZU74omBGvXO7k
	 SchKPPkxOmwapqP05XGa+yBh5/622twNZMnUWQzbM0ivQWx+DLZseYXEFKI8NuPia0
	 hGpgUMt+YmyYw==
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 6C2BB1800186;
	Tue,  1 Jul 2025 15:26:04 +0000 (UTC)
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 8EC22180016A;
	Tue,  1 Jul 2025 15:25:58 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 01 Jul 2025 23:24:46 +0800
Subject: [PATCH v2 8/9] char: misc: Define fixed minor EISA_EEPROM_MINOR in
 linux/miscdevice.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-rfc_miscdev-v2-8-3eb22bf533be@oss.qualcomm.com>
References: <20250701-rfc_miscdev-v2-0-3eb22bf533be@oss.qualcomm.com>
In-Reply-To: <20250701-rfc_miscdev-v2-0-3eb22bf533be@oss.qualcomm.com>
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rudolf Marek <r.marek@assembler.cz>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, 
 Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, 
 Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDEwMyBTYWx0ZWRfX8WZkjfvhWomm
 Yn1rL9RVQ7XDC2Ork8uYDE/q20bG2f5ny7JuF2GDKDmFklgF6uftqu/GXwWHTpcOygvkZCxlOMn
 lIjvAEv2Gw+MmHipYnL9Fcpegf7kzRh/B8RurEiHPgPvi+jl4NqQoYnvBOwO4kZRaIYus8R8WTB
 rdikm+W0H5UMAV6pUM6vWVvXwZzNYz5fVSY2L03wPfUe2GRQaxqxwvk5OgjSsmBqbgZ9XCDPr7J
 M6FiO8PycMWI9twve3+p/mFxR6KDUhe88Me943sujaMLx1Opw6ItLyMdiayzw8VfLBOcdg/EU=
X-Proofpoint-GUID: yyvlQ6rH9tTbNWYQqWHKrhmSzJibS44p
X-Proofpoint-ORIG-GUID: yyvlQ6rH9tTbNWYQqWHKrhmSzJibS44p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015 malwarescore=0
 phishscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2507010103

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

Move fixed minor EISA_EEPROM_MINOR defination to 'linux/miscdevice.h'.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/parisc/eisa_eeprom.c | 2 --
 include/linux/miscdevice.h   | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/parisc/eisa_eeprom.c b/drivers/parisc/eisa_eeprom.c
index 443b15422fc179c7379082bb165ea2bb80785fb3..601cbb22574fd64b0c6be568442d5064d38a2c20 100644
--- a/drivers/parisc/eisa_eeprom.c
+++ b/drivers/parisc/eisa_eeprom.c
@@ -15,8 +15,6 @@
 #include <linux/uaccess.h>
 #include <asm/eisa_eeprom.h>
 
-#define 	EISA_EEPROM_MINOR 241
-
 static loff_t eisa_eeprom_llseek(struct file *file, loff_t offset, int origin)
 {
 	return fixed_size_llseek(file, offset, origin, HPEE_MAX_LENGTH);
diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
index c33839df8bd261bf1ab841b7e50afe3f8b0b007e..632263f4d8393701022dd31942f58e901dc087b0 100644
--- a/include/linux/miscdevice.h
+++ b/include/linux/miscdevice.h
@@ -74,6 +74,7 @@
 #define UHID_MINOR		239
 #define USERIO_MINOR		240
 #define VHOST_VSOCK_MINOR	241
+#define EISA_EEPROM_MINOR	241
 #define RFKILL_MINOR		242
 
 /*

-- 
2.34.1


