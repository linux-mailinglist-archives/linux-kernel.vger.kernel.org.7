Return-Path: <linux-kernel+bounces-829486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 543D7B972E5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF394A6C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCD53019D3;
	Tue, 23 Sep 2025 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PbBkLF8j"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2465E301031
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 18:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758651395; cv=none; b=Wyesg7zJo4Bflx7PGJjelPmXDZ+DewWGHVf/U+xER9c6stY71U7zOJqOkV3kxt4tKaNjMlBfB675if0mhd+iJU0clQKseg1ss+dGyZTj8D2y1AwRuNDbfsG1yjxFGd02ZiVZnhdmbztMViFKiZFa11cjdyz2B/j1V17eKOB1TxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758651395; c=relaxed/simple;
	bh=DjrdL3XNgIEmjnDZUgxCJVacJBgkP5c1CvBouxNo9Ig=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 Cc:Content-Type; b=VGtYkWaEiMIpUQ47wWyJCI5keeysQKpYhdtFclORDP5RzQvUTyNKq6bc9ZNcGQ2It7hudc7nki65rbl6AXQL+1tGBu/VSKrpCK5ryHHH+z00dFPVE5UvPJMo9ocHfT2FP3ugO7LQcEd0yKUZ3dH3X5SwKnZhK0Yd953WXWeoxHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PbBkLF8j; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77e7d9ed351so3739058b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758651393; x=1759256193; darn=vger.kernel.org;
        h=cc:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LDsb4xPeq/BMfFOTOwhbZUrPAk2OaBUYj9EJ/ye/GlM=;
        b=PbBkLF8jNQwufXUq8fjl2t0FAnrrLci4elig7WnpZcZQkVnRAJ/OqabOyY9+d1Nz/D
         HmAB52aNPPkcHwI/YAnlyX9iD3JBXuNGkHfAeDkdcvtjIKoven2KhGNBqijEY9u8ANJp
         LG0NbUK7H1LFTrqJjZ4V4z01Oev5aoACmS4RV78+pO5YshcMn99lwOGUfvB5N+LIIeNk
         NeA+Du8SMObbn22x4Y/2ewbG1DS0mOctGw9M3LdoYkcGs/xVbA7JbJZKUFFmEXUOElEp
         ztwgeJS9Yn6BlkCzqZTI0Hd4yDB5FhxWWlPRkViqUjApGZPUibAMfTv2o3etq6ufu0X3
         bhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758651393; x=1759256193;
        h=cc:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LDsb4xPeq/BMfFOTOwhbZUrPAk2OaBUYj9EJ/ye/GlM=;
        b=VVOhuPznMg7IvWuI2e1EVMXfTH7q7/BzDSE6/1z3OG0GPtmtmgS9NFA7Sha6qM4R77
         eWw8Pq1jZPv3NRE3S0h3TCBXLIwpaDNKQcYUnW/078dtbhvGXuCSE19f3kvW8ytin+yx
         gqVzju6zvUhCs3rFBMPrNxKgdiTmAxRkI2wQfN8WgBuijTxTaGbdIM3TKmmZCs/+TTOb
         Y2uhZwbc/wL3Zw7DM7NyXa1pZ+ZwBFqsb1H9+GJsrvo+5zaHoMJRDAauBau/J5GFFKfp
         Jz5gWjkC//x0cpJcwOD+c/SLTisILHaHGT5fvMYqz/HL1bjPPEWYOmUHQZgvE5aM9UAg
         jwJA==
X-Forwarded-Encrypted: i=1; AJvYcCXF0AhCAExoxqIzazpoAjEK6S6CaVZp3up20GWfbPUE3hLR4XhWVbv0aIrnkKgwlTLm4avRBgaU6LS0lZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyasyawf2c0JG/PPZ6URcH75gZQH0Clb6Vz4ywOyDc6RI4w3SqY
	59/2VffvMRvBWk7Fz0es/IrEswo9XNaxCsJru06KbZi/kDIBGboHEwl+Vtjl7JEBLqMi1/EHt9h
	cw1ZI3cpAazW6VxQRTA==
X-Google-Smtp-Source: AGHT+IHvf4Fg5sTJ5MJYBXvmU3VTto3VB7QYtiTPvmQq21LrAIjuUIrGQO4eDxSNvwAxySl6icuRBOUm0pMvRfs=
X-Received: from pfblg9.prod.google.com ([2002:a05:6a00:7089:b0:77f:3341:eef2])
 (user=rdbabiera job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4b12:b0:77f:2efb:11d5 with SMTP id d2e1a72fcca58-77f53884467mr4332564b3a.1.1758651393368;
 Tue, 23 Sep 2025 11:16:33 -0700 (PDT)
Date: Tue, 23 Sep 2025 18:16:08 +0000
In-Reply-To: <20250923181606.1583584-4-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923181606.1583584-4-rdbabiera@google.com>
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=0B74D21BCA57BD40083A73A0DB00FC8CD80B20A1
X-Developer-Signature: v=1; a=openpgp-sha256; l=988; i=rdbabiera@google.com;
 h=from:subject; bh=DjrdL3XNgIEmjnDZUgxCJVacJBgkP5c1CvBouxNo9Ig=;
 b=owGbwMvMwCV2m+FPzw1uhYWMp9WSGDIuPX6ut7hTXcHq7tG2hZyMR16VGYnOvJ9458nLtTdzd
 Wbsa9UM7yhlYRDjYpAVU2ThLrkkfSp8rwOHVfECmDmsTCBDGLg4BWAiM6cz/GL+OzHlzOIL+Tyl
 1auWBRvOWuS2Yban3BV5l9+Zm3jXuG5i+B9kc++tq8ResSV2KeYTJhvnPV99KDv4wkluvRqugm2 FexkA
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923181606.1583584-6-rdbabiera@google.com>
Subject: [PATCH v2 2/2] usb: typec: altmodes/displayport: do not enter mode if
 port is the UFP
From: RD Babiera <rdbabiera@google.com>
Cc: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, 
	badhri@google.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	RD Babiera <rdbabiera@google.com>
Content-Type: text/plain; charset="UTF-8"

Nothing currently stops the DisplayPort Alt Mode driver from sending
Enter Mode if the port is the Data Device. Utilize
typec_altmode_get_data_role to prevent mode entry.

Signed-off-by: RD Babiera <rdbabiera@google.com>
---
 drivers/usb/typec/altmodes/displayport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 1dcb77faf85d..8d111ad3b71b 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -758,7 +758,9 @@ int dp_altmode_probe(struct typec_altmode *alt)
 	struct fwnode_handle *fwnode;
 	struct dp_altmode *dp;
 
-	/* FIXME: Port can only be DFP_U. */
+	/* Port can only be DFP_U. */
+	if (typec_altmode_get_data_role(alt) != TYPEC_HOST)
+		return -EPROTO;
 
 	/* Make sure we have compatible pin configurations */
 	if (!(DP_CAP_PIN_ASSIGN_DFP_D(port->vdo) &
-- 
2.51.0.534.gc79095c0ca-goog


