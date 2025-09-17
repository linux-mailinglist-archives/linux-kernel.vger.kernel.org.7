Return-Path: <linux-kernel+bounces-820070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80048B7DC71
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C255A189FE1F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 06:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713E72798E8;
	Wed, 17 Sep 2025 06:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="UyTcXbFH"
Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9C1189;
	Wed, 17 Sep 2025 06:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758091062; cv=pass; b=EvKgD9ejCwKZc49KuXXYLzUfXtz0rKlgo2dX9j+DlBLulyNQydgxbL8j2klyPxa6fviDOFZ+aTqbNjwQSg5wPTQIJIY5+ip0I3a5axpt6f6QpenNNXYXt0wZDC10p5liiA0fbhbaOBHrcnd+B9MiTGGgS5GIVtkPJnTaXhr7uuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758091062; c=relaxed/simple;
	bh=suNJLgxs1Aga2VnqAJwYuN0Hk8US+a2j/HyVhdxbo0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMqMW9yn35pWEbgDhNuD315DgdIgsX+M11CxlspctZOaoTfI6L5urievbhJFkKc9yCc5RpMEPdcX8zWTRXLWFtEYt0QogHc0ZsV0buATiCAMZI2IE2koWXOv/bTdg6VSFRO3S5BsdvJml08WEOQLmRlMBBdxVEdwWetvMkIAl58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=UyTcXbFH; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58H6bZts044422
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 17 Sep 2025 15:37:35 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 3142811EE222B;
	Wed, 17 Sep 2025 15:37:35 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eP2FJUJkU9mv; Wed, 17 Sep 2025 15:37:31 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 1C9C2107E4935; Wed, 17 Sep 2025 15:37:31 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1758091051;
	cv=none; b=wFfO8JnMO5A7V7UqxdjBiEOdlZ6Rc/DoXf6QPs7KclpFAFw6ue+0PSxaTS1cttmKBSjgl5pJHfj7zkePPqifz1+Y2T0m8GT8FvuxAQ9wl2sYd/qvV6Q+6mv8sDOHr+nCub+sBPQbbsVZ8WX3NE1s0lE/8MPHuuvhrmjmJKEs7Ho=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1758091051; c=relaxed/relaxed;
	bh=ifPPiiJZLFEWER+QcyX5IQBJUn6lVsWKBasonFmOjPc=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=mZGl+oxlWKnz8fV2tOywSRpm0sJYtCM8xP8pRjS7kFRVq8hgP+9AY0EyQOAizCqD08nL5GBWc0KdyH3vbqIDa3aQ76DvJCzZ0gyGAyohKPnyMxNOZj5Kpq2UxUcKxOTXpXOgrThHmUfkn2qp7tp6p09R8d0uJZa8uLmStXyS4PY=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 1C9C2107E4935
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1758091051;
	bh=ifPPiiJZLFEWER+QcyX5IQBJUn6lVsWKBasonFmOjPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UyTcXbFHGZAFTDe6wxc9IDqmbXd7onkqBngEDOkWlDqFU2a8qvVxftZrPwXMbqId2
	 un85UQkpt3ng3G+3+DREyszwhlOKqdP9x00QgeUQ209vG8ZnIpz5J82jFCWryToT+o
	 mO+VjZDv2FXpDK07uRnh9O1hj5pc2v5UBdfEOyY4=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH v2] staging: rtl8723bs: xmit: rephrase comment and drop extra space
Date: Wed, 17 Sep 2025 15:37:29 +0900
Message-ID: <20250917063729.1450525-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250917053944.1447050-1-weibu@redadmin.org>
References: <20250917053944.1447050-1-weibu@redadmin.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Rephrase the comment to avoid the "number of" construction and remove
an extra leading space.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/stagi=
ng/rtl8723bs/hal/rtl8723bs_xmit.c
index 842e19b53421..abb6fdfe7e1f 100644
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
+			/* Total page count is not available, so update current FIFO status */
 			HalQueryTxBufferStatus8723BSdio(padapter);
 			bUpdatePageNum =3D true;
 			goto query_free_page;
--=20
2.47.3


