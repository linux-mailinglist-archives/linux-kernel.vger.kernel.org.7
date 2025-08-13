Return-Path: <linux-kernel+bounces-766473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD40B24707
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E480882DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F972F0C48;
	Wed, 13 Aug 2025 10:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kpNOJvi9"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038252D1F7E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755080082; cv=none; b=Y8qdKXyy3v96p50b6vBH+67PDMpBXX/pXXl4ZrLzCeACkhcjmUK13ZSdVkMqms16xzsmqu4Enf9HMpeAo+lrOl892o4G3mgpvdvNBCv3DxaQ59FmA7uLcuiNdBHf2PnjF3/UrazaRM7ptcjbWbI6KbaD0zdMZrZTkELNN4eJDnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755080082; c=relaxed/simple;
	bh=RnVSME/rogwEOBK+j6+fLeml3CKH5bpNmM9U/IxMiMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dOJm7hG3jJPBUZXPokenayFEanUGjKqOEqWKHD5Xddo7qlkTJBr32TmzPJckk751/Iy33vH6gGnmNjM18EM4AOXsvva2ckiZ38APH+H59kKKwj7swYcqOfyd9+h2aEbFEdUscVNcKqzb9kAQsb7tqh2UQQP5xtLY4DFg5cRJ/aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kpNOJvi9; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755080079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pv4CHsTtOFzXF65KnF8iE3uf5kBWd2tkurIQwheweOg=;
	b=kpNOJvi9odUDIJ4dCPRFsQyk6NB2YIK6iRGvUcs8zijAHVZChHLsYUCKdOSn1tYZG5cJ+T
	IB+5UZ0BismvIn3aKJfozQ9MrRjsocteI4zaEpqsJTAI+EShdOkZ9Uxp3AdylYaoAZX7li
	3izek3Sfh7QVt50OKnWzkmkpxKv1nO8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	wwang <wei_wang@realsil.com.cn>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] usb: storage: realtek_cr: Use correct byte order for bcs->Residue
Date: Wed, 13 Aug 2025 12:12:51 +0200
Message-ID: <20250813101249.158270-6-thorsten.blum@linux.dev>
In-Reply-To: <20250813101249.158270-2-thorsten.blum@linux.dev>
References: <20250813101249.158270-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since 'bcs->Residue' has the data type '__le32', we must convert it to
the correct byte order of the CPU using this driver when assigning it to
the local variable 'residue'.

Cc: stable@vger.kernel.org
Fixes: 50a6cb932d5c ("USB: usb_storage: add ums-realtek driver")
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/usb/storage/realtek_cr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
index 8a4d7c0f2662..758258a569a6 100644
--- a/drivers/usb/storage/realtek_cr.c
+++ b/drivers/usb/storage/realtek_cr.c
@@ -253,7 +253,7 @@ static int rts51x_bulk_transport(struct us_data *us, u8 lun,
 		return USB_STOR_TRANSPORT_ERROR;
 	}
 
-	residue = bcs->Residue;
+	residue = le32_to_cpu(bcs->Residue);
 	if (bcs->Tag != us->tag)
 		return USB_STOR_TRANSPORT_ERROR;
 
-- 
2.50.1


