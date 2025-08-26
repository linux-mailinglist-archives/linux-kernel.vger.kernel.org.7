Return-Path: <linux-kernel+bounces-786208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A85F4B3568B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65DE4241A38
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0620F2F659C;
	Tue, 26 Aug 2025 08:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUpypntO"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85DC1487D1;
	Tue, 26 Aug 2025 08:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196279; cv=none; b=pL7H6MiTGquVVwPOwMJV+abbjttPdi8FLhFJQ6Z1ORANXBYOsDf+mAFD5xt25iQNaHt7+AB3r/X/EwDddpRBybikQBOf8KS+WZtwqOCS5+u84LaivRW/Cqpo6KAPzjVPgNJuuSCShHKgoImsOIo4ZGAm6h3fQudBZ5/E8onp9G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196279; c=relaxed/simple;
	bh=LMGUqtcZeT7/g276uoOG8szisYQQkCxA0/lcjLZV6AU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZNQ/kKgChsjfdcpQAXJhnBjoOmjh49GClXZubOXJk9xQ2CmyRPsKg2B+rhpa36VDBHjYWduptSKLZ2n1d23h1LpxgB3vk6Dbcljhw8eWjCWWhoBfw5VmgLsO2tSlZIHpq/2uaOiQYtEbAPGeS8rrE4IOq0kxLDkzWz3RcXetHJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUpypntO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b618e067eso11011945e9.1;
        Tue, 26 Aug 2025 01:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756196276; x=1756801076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LJUJQoyHSPHbY3KTaWEDFqhSXMoUl3AzxQn8TTn8tek=;
        b=eUpypntOvS37U6HjgzkoUR5siyt+Y9ph/C24VebdEx1kiC0HAgwHbz3kPuRTr/9Zoy
         B6ywgoym6QKmLhLYtzWaynX7T5mewXE2YHeh6h8W6KcgvbMubbDwIUlqcpLLYzkDyXkI
         IrkRvIH091ZM/vIZqPtB6LT0eDD6JvWreQALxCqoZBIiwXFzQ0d4kglbS1scrtR4Z3Dn
         u/86bb5H4ItUYajTv4IrrFGvELjZcKJqUusP3d3G0bWDfBxOdBjyAkOGgIdDVjkhngMV
         /CQ0mrJh4BcJvFTk+eOcQCSmKxRXvEjc8R6FPF1Y9zM91c7qf3DVnQo8pUezSMOPgw5f
         SSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756196276; x=1756801076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJUJQoyHSPHbY3KTaWEDFqhSXMoUl3AzxQn8TTn8tek=;
        b=YkbtsV7hv/3bJYv92wc+ASCpWfSW0tR5IhFeDodqhc1mK8jxQlrPc1NRndkZzFYmo1
         52/MpUStE0gLt91j1sDNQkn/cE24vKq/IdOslSBwkqi6BQCHW2HAgblSXy884jS7tvNn
         YudBhXLF22dKT2bRpPduURearctT8WuNkgYgSzITKz85dV/sRWVYzwZg3rDmWPFqaNVS
         2/Vpjh/1/VXJ1rsiVMK4tgcDZN0Z2Dz7R9t2jflEdEbHD8Vqai9fPlMKXv1dt/rygr8W
         D/FQffM184BaPNOzLMVeLKMhfwgFSNPItPSmVFJgqTHWEQXXRw2R8KhAOvHLNU+GFN5D
         fkMg==
X-Forwarded-Encrypted: i=1; AJvYcCWpTq8zwkkH/IbXnYFfU8UpcOqLZQjluTtJEnEl5DsHnN/19GsTqq616RhXE97DqHCm3cdHBBhf3QAX@vger.kernel.org, AJvYcCXpoCHfePZC9Cl2DMZ/ceLcPahlj9eueyfKNyAPbBhQa/28MJpjmw2vjlg/on6Rw4/MSUaAQtXmhHg+2BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG1vAAnAlz53LbRUx1DYMr5HCfzNQZdVQZCH18zuHLKrAaPwee
	go98gveaWtA06CykstcOs1T3Yev24vltOKwtTsgGpsEAgzfS16ay+vK4
X-Gm-Gg: ASbGncvfNPjH/NZDIG/rFhFNveN0zEQQCp8LZ70Uvz/7gGqsW6a2G3MjT6e9FCO60W2
	fohUfBql0ANPPe0LbZooGtkSECzlEZSvF4Q4KrQIE38QRLCUv4akAkrft/WaCJPZ7RJ2K3QcAfr
	Uej28bA01diZqOPw7FJ8b3P5L5DItKnZ+NVJo9ZHMpz6vbG5ei21I/GMlF4Rc9YecQh4yxnDENP
	9q5u0+EWvCTENsk7MqbQAMH8BLsFmXFP+KOuxoMqE7HjPFEoJhjlVUMacZTs2Tb34+BnzWZG/w9
	9gx6JmV0su3ww+rgCcThVQnICawJAaZSTn1wYzzlSI3uTzUVCVTfgUUobF4v7G+KGqC623GVYqI
	PkqM+S8pxIdhNq8wCBwor
X-Google-Smtp-Source: AGHT+IFYFc10tLW0YGsmzF2EtA7gngRNsl8XML7EAgQtXXeTV6Em3ObVTXtgXi9jOujJAzDo9JsfNw==
X-Received: by 2002:a05:600c:a20c:b0:456:1146:5c01 with SMTP id 5b1f17b1804b1-45b6870d983mr4539175e9.12.1756196275810;
        Tue, 26 Aug 2025 01:17:55 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c711bb1d3esm14970896f8f.55.2025.08.26.01.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 01:17:55 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] USB: serial: remove extranenous ; after comment
Date: Tue, 26 Aug 2025 09:17:12 +0100
Message-ID: <20250826081712.1415484-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a redundant semicolon after a comment, remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/serial/oti6858.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/oti6858.c b/drivers/usb/serial/oti6858.c
index 24068368892c..bd206cb9cc08 100644
--- a/drivers/usb/serial/oti6858.c
+++ b/drivers/usb/serial/oti6858.c
@@ -106,7 +106,7 @@ struct oti6858_control_pkt {
 #define PIN_DTR			0x04	/* output pin */
 #define PIN_RI			0x02	/* input pin, active low */
 #define PIN_DCD			0x01	/* input pin, active low */
-	u8	rx_bytes_avail;		/* number of bytes in rx buffer */;
+	u8	rx_bytes_avail;		/* number of bytes in rx buffer */
 };
 
 #define OTI6858_CTRL_PKT_SIZE	sizeof(struct oti6858_control_pkt)
-- 
2.50.1


