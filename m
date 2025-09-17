Return-Path: <linux-kernel+bounces-820001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 839A6B7E86D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B431BC5A23
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 05:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700172701B6;
	Wed, 17 Sep 2025 05:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="LlbmYB8z"
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE893BA42
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=157.107.129.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758087595; cv=pass; b=EJ+A2nBGgeLllYvjZyC1pOsgfTHSprLQtJ5Mm6/N3TbcyAs67V0lBIjEDuWqz4H1+ofirYKqJZdEJvZkjBEKYkxwYods2ktbooxIzZ8g0GEUBc9bLgf51Fs+tA+aRNRX3nMIsg+WSsDDX2HI/pSxAJGwHjQKaiqAP/rD5Nesqqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758087595; c=relaxed/simple;
	bh=wA4Sdy5qAeGVci/6dh+BdP/LbgKn7EJKYYT40aWauus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZqsQ39Vm3vWX1o3IhRxDDONeWNbLUfavUO9u835ix4zOx1jRkrTxSQ2faSlllRAA3KLy2WITJ1kzzA0yCsZmuPQXaotBDoeqslLqzZInqBcRnkpDl9VC5HS0KWK/0ZDAhRx/VP/PZdvDLZIptb5LFIP/UYZPBLB/F5CInj95Jso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=LlbmYB8z; arc=pass smtp.client-ip=157.107.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id B36DE11EE222B;
	Wed, 17 Sep 2025 14:39:50 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5nZaNkphslS6; Wed, 17 Sep 2025 14:39:47 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 57EA6102D055C; Wed, 17 Sep 2025 14:39:47 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1758087587;
	cv=none; b=ZNUq/N61qmIYpt8EczuTncPxJSXZ+y0npSGNq4MGb52Ukzb31v2aOUlNr1pI4Jteead03P0IXMawvN9DtRN3bbtEuViV4HHKsUOrWYfCUHnIHAj1oNta+Rwg5aSeyfRZ2CwWdhoJqUA18uOrzkJNK31T0n9IGpYb8M/979Os6tA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1758087587; c=relaxed/relaxed;
	bh=gOOHUG76rF/OweQcl97emjPlv07dmVrCW2sdCuTxTUY=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=p9P6zWoVgl9I6rX+8iGVoWazZAzgyC94aNXse/B07XZ8UTxeHgxDBPeraErKjGPJzAJcTLXLqT331GconylRo73ndm0vQK6gl62atYjYr4KqOF06vbMn02D39ElNQyLX55D1uiWyWAbsHoJdIIVjxV2ya2daxBc5Yt74XdhtUDM=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 57EA6102D055C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1758087587;
	bh=gOOHUG76rF/OweQcl97emjPlv07dmVrCW2sdCuTxTUY=;
	h=From:To:Cc:Subject:Date:From;
	b=LlbmYB8zWRznfXUR2ijx3tPIU+rPrLD6BR48kGFxd6yXKQfNTwpqOlkdOvhcEI6If
	 6QuiA2itvf/PTbosAE+0xDlg2qUuoAkIqX0EG0l6OC+D58KvwY+fWdDDOoaHFbiyYj
	 dVfKNaUs64QFkJM9Odyh17OeO2BeWqZivc2uJbrU=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH] staging: rtl8723bs: xmit: fix grammar in comment
Date: Wed, 17 Sep 2025 14:39:44 +0900
Message-ID: <20250917053944.1447050-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix 'number of page' -> 'number of pages' in a comment.

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/stagi=
ng/rtl8723bs/hal/rtl8723bs_xmit.c
index 842e19b53421..7ba8981f4652 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
@@ -76,7 +76,7 @@ static s32 rtl8723_dequeue_writeport(struct adapter *pada=
pter)
 	/*  check if hardware tx fifo page is enough */
 	if (!rtw_hal_sdio_query_tx_freepage(pri_padapter, PageIdx, pxmitbuf->pg_n=
um)) {
 		if (!bUpdatePageNum) {
-			/*  Total number of page is NOT available, so update current FIFO statu=
s */
+			/*  Total number of pages is NOT available, so update current FIFO stat=
us */
 			HalQueryTxBufferStatus8723BSdio(padapter);
 			bUpdatePageNum =3D true;
 			goto query_free_page;
--=20
2.47.3


