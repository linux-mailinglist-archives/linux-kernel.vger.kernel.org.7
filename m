Return-Path: <linux-kernel+bounces-720437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C08DAFBBA6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 21:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D6E42541C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4748D266582;
	Mon,  7 Jul 2025 19:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="OYJYOE5+"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBA523027C
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 19:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751915895; cv=none; b=nqpxFo7nbhHhG+gsx7O0C/auX+i+liW1I3XRPtu9b6aQH59G4I1M7iM5adZ8IS7adLyiitXk3Zzal1BRhfUvqUPmQju2L6eaxUBEGoZtn2GLmTRQtuDg90YNXX1ZUvD2+dvIDaNkFTbgwyEsK/ZUP4Ugw3/awlpauQAqsdcCiZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751915895; c=relaxed/simple;
	bh=YF9SUdNS4UFtTk087mgYFaRJjT30f7TNpxtcud3aEYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWy3hBp0CmGctLD/YNd+FcrkjtWFjl1q5dSZYiHCJqfvEvei2pD4RC/tMnUmnyjC/dnGsKDRh6Z8kWDtROvbpDBbrSU1LYb1dKdFf5YY6KIrUBX3HjqKvDVU3XVBySQhV9MQ6ZIkHQVE9bkHR61E4DX28niiHCCy5N4h1ILexUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=OYJYOE5+; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-701046cfeefso68746226d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 12:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1751915893; x=1752520693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=86Um/oGfXBVHaAngu0B8h+3DIlXKpnkZFqZaOl/fGcM=;
        b=OYJYOE5+pIl0pgrqSgNZwYJmkrX8eaD095eeFLX+cqcd5wiqtwRNFVJwacGzXLFHxp
         VTHtZ6oA3oxJfh/YA1UWsBUna57qnsH8hU1kkMNxlVOyJiOnrCNIWmQW1tUDlOKRFu3C
         wV6YAuw0CBBYuEab2nash1/8nyEiwnjSyldADQLRCJNFz8E3b81UWWS6BIzYnJMho9Sw
         OB0n1lihLebHzgu5Bg6g/8fXS62OOJO5cVMuqR9/TfkLe9HgotKVL+e6fbzpUt+tOkv7
         ZxgIvhjf4Zaldepg0ZUZBg0faPkPpxBndy2u+xGv/v2octIclzE+kRvZl2dPYsd2S6RE
         cOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751915893; x=1752520693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86Um/oGfXBVHaAngu0B8h+3DIlXKpnkZFqZaOl/fGcM=;
        b=qKfeSt1DOYa/U8YKuxgU6dfsmqMtrgAzz7r3lyIaMi8ytIpnmvtPVf/jFfRibKgZrP
         rjQaoIdM8IISDgZ34tPkiMFte8SZxx9+rbjaddiyIRnhjLDN4QpF3j5Y8/bzLWgpkQrI
         U7tdggjb6vQPDTGhmKbcjYWjXLFlGs1qRBFhdBN7Gu51+zKeoNcknLzM5oVqOrqEM3jF
         19ow1e8u0EyDKuqxYhWFuqgmS9N4qH2JpH4EoY3oxr+HgOidA/kpqlfSd/G8302DMmSa
         AOLx4GYRl3YEkEsRgO3mVbzjwXBLDjyvkPWs9l7oVLfe2gcVmecBPkDRMSkbTCIbILRF
         +K9A==
X-Forwarded-Encrypted: i=1; AJvYcCUImdHOGbhEf65TIT6LRIQV6s0nSKXswubiGNWCCBn1WLcG9EnHoTV/MSxfKdQgwEzN+/bk87JxKN/egjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywul7rn75ifE9d7/hD2btZZwLQZir+3SwQhgofPvfevFErXjfES
	IIRwYLtKNoXBsXUilxw6SS5ZM1xgVaIRAQtJqFTEdFK/qJ5Xzme200xzz9ThcBroSg==
X-Gm-Gg: ASbGncv5rzTm4teeKqm3inK8RXRVI5XmZg4LeEXSEdfxB84mTrylV4lE5Zn6baxY9a6
	Lhs7SS0t0pFyj2r8NyVbB7KXtOlUhqvFRpnW2uiXfMq3Ma1F9/8AQZUi8wlnyKpEKK2k+xDg3/7
	oK9BXkK9AEjPAXkYEVprokhCCEbX59+/byDgTxwxX6+b91duUiETcPOv0Khr7t7kow5g04twD6U
	DteA86FQseG1ThE1xsefw1CNcWgUuIvAqO7QWvTPtDEYxzs3i1sYunJJkISNHccykDC0LODBOnN
	pvRwnZKv8YoypRjIlKB3sQo8aiBM2oowOAgT1xyfFPjXhd9CA4UHN4MI0tEm+gE7hjrKL8iD2q1
	5u8sMtProhX1Qn2g4te/OzhXmH6nrQc34YOI9HNT3j6KCC/eiufI8j7Q=
X-Google-Smtp-Source: AGHT+IEsXOhPOpYzahtFBIem1W72v4wRmVgiUgUVjEEfhHLpilQo8hWzadCpQVVWgg0u28b40ROhiw==
X-Received: by 2002:a05:6214:419e:b0:6fa:ce21:cad with SMTP id 6a1803df08f44-7047cf09751mr9817856d6.18.1751915892554;
        Mon, 07 Jul 2025 12:18:12 -0700 (PDT)
Received: from rowland.harvard.edu (nat-65-112-8-52.harvard-secure.wrls.harvard.edu. [65.112.8.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4cc779bsm64489986d6.19.2025.07.07.12.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 12:18:12 -0700 (PDT)
Date: Mon, 7 Jul 2025 15:18:09 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+8258d5439c49d4c35f43@syzkaller.appspotmail.com>
Cc: contact@arnaud-lcm.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	manas18244@iiitd.ac.in, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in
 mon_copy_to_buff
Message-ID: <72fea4f2-40d7-4f9f-a08d-b1ada781256e@rowland.harvard.edu>
References: <5de04492-01d3-4b2c-b3f4-8c2237dfed6a@rowland.harvard.edu>
 <686c14c0.a00a0220.6237c.0000.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <686c14c0.a00a0220.6237c.0000.GAE@google.com>

On Mon, Jul 07, 2025 at 11:41:04AM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> KASAN: slab-out-of-bounds Read in mon_copy_to_buff
> 
> microsoft 0003:045E:07DA.0001: unknown main item tag 0x0
> microsoft 0003:045E:07DA.0001: ignoring exceeding usage max
> usbhid 1-1:0.0: count 0 reportnum 0 buf[0] 0

Aha!  As I expected.

> ==================================================================
> BUG: KASAN: slab-out-of-bounds in mon_copy_to_buff+0xc2/0x170 drivers/usb/mon/mon_bin.c:252
> Read of size 3904 at addr ffff8880222d53c1 by task kworker/1:2/3689

Let's see if this fixes it.

Alan Stern

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ d7b8f8e20813

 drivers/hid/usbhid/hid-core.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

Index: usb-devel/drivers/hid/usbhid/hid-core.c
===================================================================
--- usb-devel.orig/drivers/hid/usbhid/hid-core.c
+++ usb-devel/drivers/hid/usbhid/hid-core.c
@@ -911,14 +911,13 @@ static int usbhid_set_raw_report(struct
 	struct usb_host_interface *interface = intf->cur_altsetting;
 	int ret, skipped_report_id = 0;
 
-	/* Byte 0 is the report number. Report data starts at byte 1.*/
-	if ((rtype == HID_OUTPUT_REPORT) &&
-	    (hid->quirks & HID_QUIRK_SKIP_OUTPUT_REPORT_ID))
-		buf[0] = 0;
-	else
-		buf[0] = reportnum;
-
-	if (buf[0] == 0x0) {
+	/*
+	 * If the report ID number is 0 then report data starts at byte 0.
+	 * Otherwise byte 0 is the report number and report data starts
+	 * at byte 1.
+	 */
+	if (rtype == HID_OUTPUT_REPORT && reportnum > 0 &&
+	    (hid->quirks & HID_QUIRK_SKIP_OUTPUT_REPORT_ID)) {
 		/* Don't send the Report ID */
 		buf++;
 		count--;

