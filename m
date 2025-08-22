Return-Path: <linux-kernel+bounces-782066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7BFB31A61
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6214E7AD048
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1032030EF68;
	Fri, 22 Aug 2025 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGsJDu2D"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF093054F0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870922; cv=none; b=hKxW78td+v/nMUimsVgE1yDrMDl50opV/+Zv5W/t69tlxKfCoorYJ7Dnu79jJ8OK2w854Xa7fiD0IJsLZSAAxvO5nJ8a8193puP7TbyLnDR0+LuhLdnI7knMa9Cwq2YR0I5K/yYvud6sN3opkFmwj2btL0nT7kWEhsOW1lMZLU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870922; c=relaxed/simple;
	bh=iMxJ6lRTsZ/+ONdW6aaFlSyS67Ejco0VfoBbud1ISW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H52Abu4knKua1jn7TfFXCk31rKmJBang0UOU5QDekeRNev//ktJPphE9LysjfBHdVy2OFUWuLYqlVxJOv63JRIsunxmvB5ysJxM7KRPPng4fazGPkhwmECkshzfedbhFIhC/W388O335oArWemkv5pukImUsc7u6IH2e9TY195s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGsJDu2D; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb73394b4so314271966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755870918; x=1756475718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izOus1pkUT/TrM+qzEvtIeTOKYw7pk9oz7PKskT0MOs=;
        b=bGsJDu2D1myy8t8+icMgZjDBFd+NSBzOg+HyExWlqfui3LQeCw1+MKAjtD2fZKIoAJ
         VIVicP1RhL1Pzl5dspo+eNLk6xnvaomwUoQgGshGbfGfDk5lhj9lkbrjmK1iMktBpT7/
         rrJ/4oNAHSPa2Aa/kh1eEjxl3UMczRET/fqvIAqAXGaACnVDcuHOa8bGLCWZfIEfYFXk
         dSqPIbM0lIxoTLllpNnqXKrec7EKOEoQrsHDhmaa8PL28JfSXoAhAh3GKcZHhJ3h6AZU
         TRqBBSIYM67xTDNpU7I2+J2EIBhC/foMSeT92Pux44k7nLVUX5+3vR11/s6YO2ALsyub
         FDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755870918; x=1756475718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izOus1pkUT/TrM+qzEvtIeTOKYw7pk9oz7PKskT0MOs=;
        b=ITUV039iP1EKE8fymUzphHInOR88X1UuJMdx4miXf4VXvUuYoGOyf3Y8o/yvkXF6Hf
         Cn+rrUJpys0djBolpMUItYzVoDHLF28ttdnFtxU9JBw3/+i3CkDUHFRIu0gmOAQpsXsr
         uv8f0fq8O7zlbYQGPVhDw5PNslStoFdNJwnbCVHmcGDgaPV5HBD3jSJnTck5H91wSOuR
         0gSKsfJN1dxf8zodHYyp+V68aAAJBvgaCpsDBjFGmrF9HH1ruLh0NXDFBbpBXT5FWNWL
         rPvirZy/4JwRkpgNpQw3avJOn/DtM0YMAIjMH8fgwUi4LaagsMc6rxq8LBnB5x7c6z51
         MTLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2vW7j5KZ/+R+549KJpC8v19MKtkT6Nqd3KP45SPXhJshepPUMkhORoGdo/mNVByMA5ut4EGpo8L9NEyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRsR7pZk5XuAxouEFnozvuh0NLirZFMJHe1o5H00tgme8DRaf7
	SbXzF+vNamByrMIdx271BgSajUS3/M9dl+uC8n4hS5/q1I42kzFjh4jQ
X-Gm-Gg: ASbGncsKs9B9xWjs/sc2JPyzZ6DDKDhHxba5e+lnCHBOshxhfXBvqzcwO1V6mgeHwjI
	jawJ6MqQlbEOJdsdF9psB920HEHeAQpFQQEp7gKCD98U29jxffN9IaZoKcIvoEb1q7iV0lEv48X
	R6smVyGf7lrhFAwL1ytiW0b18lep5Inr8p2PqjUGxrYvlkPl4gWuGxy+KVacCZkWLda5lzMXACZ
	Rd5bwxGrML34k3pwg+wkwAQIXcu2T9O6x73zkgDrwiPpns4qMlKQhu2HyM6RZZfr/MFChUAiTbY
	6hX+ovdDN3b2jfqOVgz9xa2n7srSdqdaLqtbRRgbOdyKCOT6VB6AQxVfv9ICkRn9hG0uiE2YN8z
	ed0Wfg8iYOKfHEFoJwj3gfsLjj04ZOGwkC1RG
X-Google-Smtp-Source: AGHT+IGzOWE/MUzoEMMp5es42MONAAnkQmOqcY/iO34lssMR7iWmGBNBPijyi/3L6YIXM2hQwObTAw==
X-Received: by 2002:a17:906:d54f:b0:afc:a330:e423 with SMTP id a640c23a62f3a-afe29041e9emr249651166b.42.1755870917696;
        Fri, 22 Aug 2025 06:55:17 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded307138sm612353866b.45.2025.08.22.06.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:55:17 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 11/13] staging: rtl8723bs: rename rtw_os_recv_indicate_pkt
Date: Fri, 22 Aug 2025 15:54:16 +0200
Message-ID: <20250822135418.118115-12-straube.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250822135418.118115-1-straube.linux@gmail.com>
References: <20250822135418.118115-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename rtw_os_recv_indicate_pkt to rtw_recv_indicate_pkt as the _os_
indicates operating system dependent code which is unnecessary for
in-tree linux kernel code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 924a0c415a1e..e893cb6fa273 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -1662,7 +1662,7 @@ static struct sk_buff *rtw_alloc_msdu_pkt(union recv_frame *prframe, u16 nSubfra
 	return sub_skb;
 }
 
-static void rtw_os_recv_indicate_pkt(struct adapter *padapter, struct sk_buff *pkt, struct rx_pkt_attrib *pattrib)
+static void rtw_recv_indicate_pkt(struct adapter *padapter, struct sk_buff *pkt, struct rx_pkt_attrib *pattrib)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
@@ -1771,7 +1771,7 @@ static int amsdu_to_msdu(struct adapter *padapter, union recv_frame *prframe)
 
 		/* Indicate the packets to upper layer */
 		if (sub_pkt)
-			rtw_os_recv_indicate_pkt(padapter, sub_pkt, &prframe->u.hdr.attrib);
+			rtw_recv_indicate_pkt(padapter, sub_pkt, &prframe->u.hdr.attrib);
 	}
 
 	prframe->u.hdr.len = 0;
@@ -1890,7 +1890,7 @@ static int rtw_recv_indicatepkt(struct adapter *padapter, union recv_frame *prec
 
 	skb->len = precv_frame->u.hdr.len;
 
-	rtw_os_recv_indicate_pkt(padapter, skb, pattrib);
+	rtw_recv_indicate_pkt(padapter, skb, pattrib);
 
 	/* pointers to NULL before rtw_free_recvframe() */
 	precv_frame->u.hdr.pkt = NULL;
-- 
2.51.0


