Return-Path: <linux-kernel+bounces-823438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1261B866EC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4922A794A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F672D321B;
	Thu, 18 Sep 2025 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b="AJG6ENYL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="VcCpzc4Z";
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="FjvTTztm";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="35DEH1zv"
Received: from sender6.mail.selcloud.ru (sender6.mail.selcloud.ru [5.8.75.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52E221B9F6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.8.75.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758220922; cv=none; b=gZuwGtZHhEKZQNSfcZPUqY8bdA3m2epqkivEjo5o+xWELxMuO4dCcN3OeMV+QvKZVAjRxk7d88uoy6fqY0t3qcKA32IwzPLVuPrU+hjBmE3KqRSIhy5JRdDkXA9VWjhjauSKMe3vA15gDQqRWsDD3Xa+C8QZgPCLQH8mFNvOLgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758220922; c=relaxed/simple;
	bh=U+DyOxDRpMo0MMZF5UsToMjLjd8dFcfr9dOVlOVgbB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MSG8RocJ4CBP+1nQ4WwhYQBfgV/Zf8hoTOCQK83WrZ6QV8hU+dqZ5v8lUfh3GCj0n4RvuWMN7W0hOrsSk0tux5WZdjRujW68rZRMv6gkxYvpIiPnoF4O5+Cj04u4gAhMptTXDrSWQhPBBNtdbFVO4eB1u9Aicr6rT/FEwCRjj+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=mail.selcloud.ru; dkim=pass (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b=AJG6ENYL; dkim=pass (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=VcCpzc4Z; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=FjvTTztm; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=35DEH1zv; arc=none smtp.client-ip=5.8.75.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.selcloud.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mail.selcloud.ru; s=selcloud; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:List-id:List-Unsubscribe:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Help:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UWd6s5bTH+qVHLnFwQczWkwifMFeYablmKljQdQMtJI=; t=1758220918; x=1758393718;
	 b=AJG6ENYL3qAv6EG6MG9AIo9ltN1Igphu0IjReWhlhvZ8dWSMKSMFQPJhLGdJxqV8FX4YtFdtKz
	YGaKpKXEbiYZ9vEJ+3tkLN6ndG8N8YdsAL7rhFwP1ahX5i3WmFlBbId/q4dwjsxrs++mvw39rg0ZG
	ypr64EfUgNPBt5hEXCjA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=foxido.dev;
	 s=selcloud; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:List-id:List-Unsubscribe:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Help:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=UWd6s5bTH+qVHLnFwQczWkwifMFeYablmKljQdQMtJI=;
	t=1758220918; x=1758393718; b=VcCpzc4Z/SANibg79qPMbrngHPIVfzsCn0JQdkcjSvRGhPH
	kNc8mI+3NMEXqMGQgjwz+Jh6O+f2506jNjwK80GdYvPBAS/LgL44DMzpMKUsVH996mxPkpDg4EMaq
	GIswG5mP030x1QUrrJGd9LoJWVsFZRlNDZWchyj/OXof4Wc=;
Precedence: bulk
X-Issuen: 1216920
X-User: 72278292
X-Postmaster-Msgtype: 3849
Feedback-ID: 1216920:15965:3849:samotpravil
X-From: foxido.dev
X-from-id: 15965
X-MSG-TYPE: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-blist-id: 3849
X-Gungo: 20250910.101619
X-SMTPUID: mlgnr60
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1758219986; bh=UWd6s5bTH+qVHLnFwQczWkw
	ifMFeYablmKljQdQMtJI=; b=FjvTTztmk8C8ZoNm8OAqSG/P6jURI4x/5yS3B4oxSweFnzKgdt
	TVIaJzUzK7SjK/ysWU7eIqBcj4sTnQXvlHO06kTB1Rtsp+76ihqav4Pkmie7od3fl+khTYDUGNa
	uYO6+81vkamQEtDtRtLnxpfX4FKNWxkGygTDNet4OWtH1VndnndLXejYPDEdpHcFGLdv+a+9Clu
	85pYKUiFtGj6dyaxatCHpseFFj17ofiBZXob21LaB75uV1ZFsmUHB8jdc+u99VSYogAfN359ONs
	8NiWbQjrEUVDazxaxYUrvJv8XJoKoWoNMmXji51HjF/A2Veza6e4JF4MC/s7oGi8Gog==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1758219986; bh=UWd6s5bTH+qVHLnFwQczWkw
	ifMFeYablmKljQdQMtJI=; b=35DEH1zveouifOp7vqfoSaQOc4xl+gwAnESqEJwMffS+56xuST
	b4xK+GP/qpo7m0O7GW35CkaIDpYEL7L6KXAw==;
From: Gladyshev Ilya <foxido@foxido.dev>
To: foxido@foxido.dev
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] maple: fix incorrect rewinding in mas_empty_area_rev
Date: Thu, 18 Sep 2025 21:25:37 +0300
Message-ID: <20250918182544.1400748-1-foxido@foxido.dev>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, mas_empty_area_rev was rewinding to the previous node if
some offset was cached. This could lead to incorrect results because a
useful gap could be skipped. However, this was never triggered in the
kernel because mm subsystem calls mas_empty_area_rev on non cached mas.

This patch unifies the rewind logic between mas_empty_area_rev and
mas_empty_area, so they both rewind in their correct directions.

Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
---
 lib/maple_tree.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b4ee2d29d7a9..c7790fff4825 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5138,15 +5138,15 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
 
 	if (mas_is_start(mas))
 		mas_start(mas);
-	else if ((mas->offset < 2) && (!mas_rewind_node(mas)))
-		return -EBUSY;
 
 	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
 		return mas_sparse_area(mas, min, max, size, false);
-	else if (mas->offset >= 2)
-		mas->offset -= 2;
-	else
+	else if (!mas->offset)
 		mas->offset = mas_data_end(mas);
+	else if (mas->offset <= mas_data_end(mas) - 2)
+		mas->offset = mas->offset + 2;
+	else if (!mas_skip_node(mas))
+		return -EBUSY;
 
 
 	/* The start of the window can only be within these values. */

base-commit: cbf658dd09419f1ef9de11b9604e950bdd5c170b
-- 
2.51.0


