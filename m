Return-Path: <linux-kernel+bounces-813661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3123CB54907
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA207AA5650
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ADE2E9735;
	Fri, 12 Sep 2025 10:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b="MFDtxyXR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="wJlm44Hx";
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="ZAY7PV3w";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="G6Jdmu3s"
Received: from sender8.mail.selcloud.ru (sender8.mail.selcloud.ru [5.8.75.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593012DFA46
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.8.75.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671955; cv=none; b=Ahxp8s5yJAkh6KbSrtPtCcT0jD5GTeJsNG7uDeg3w0qCJy4dnw/8uHB07K6oBh+GwmDRhnWIZ80o1UB4GUMTcdRf6TK09FVT1/aCTREIUAICyAQNzDniFsPMBdmNixj03SSlslyZwR9Y/fYroyAAwWg9AcvUlnUlctRor34zINk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671955; c=relaxed/simple;
	bh=fusZ6fdZtwm9rKDRuyVLzusoDLu3U8YVnKWq5vBNdy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tAEMuAqap4UDxaT5RnkD3h0GL/fJRgSn3wTFtYl+7CqD/zikmZp8zWx2ZHCuFD3Qsvtk+2DwaAssB+xS/FpqSp4i2NEJXU1QoGVPnbMOYNWpC8u06TNZJkMieXSorK0nZ4D31SIjkvoJmJm79ge/53aBri3yYZZK4H0Cc2g9rT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=mail.selcloud.ru; dkim=pass (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b=MFDtxyXR; dkim=pass (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=wJlm44Hx; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=ZAY7PV3w; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=G6Jdmu3s; arc=none smtp.client-ip=5.8.75.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.selcloud.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mail.selcloud.ru; s=selcloud; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:List-id:List-Unsubscribe:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Help:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QYYDiAvJwYAanrg9LtISBgZCjj9+R8ndhi4A1fNll14=; t=1757671951; x=1757844751;
	 b=MFDtxyXRDLRz93tGvB+zqZ/Y6eme5NrTUgOow3GIQwitNvbUNg/rkF1g6osu3UwUJ6oQWBQ+0k
	0DEDNFtUCe8KcbRfXwVA24meWxS8x9eYMRk1phqxPKclsRLQ/CvTrGqycvO+q9NRfV0z6AQi1hSpv
	pNqy+ixEKbI8XrQ1HrNg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=foxido.dev;
	 s=selcloud; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:List-id:List-Unsubscribe:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Help:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=QYYDiAvJwYAanrg9LtISBgZCjj9+R8ndhi4A1fNll14=;
	t=1757671951; x=1757844751; b=wJlm44Hxmy338QAPghP2x37hEpPUPqVEhapg1h9PjUtHMr7
	oIoAtimalGo63RaD4VGZnOjJNejnmxdCKS2X25RVbNP1qQe+57QrIah3cZpScTd1N5jhaY6PhqmZS
	H+AK/hZLvADwLRqvTfiO2CoA6ZM4h+kVSovSwwKF1xPR0cM=;
Precedence: bulk
X-Issuen: 1191176
X-User: 72278292
X-Postmaster-Msgtype: 3849
Feedback-ID: 1191176:15965:3849:samotpravil
X-From: foxido.dev
X-from-id: 15965
X-MSG-TYPE: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-blist-id: 3849
X-Gungo: 20250910.101619
X-SMTPUID: mlgnr62
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1757670832; bh=QYYDiAvJwYAanrg9LtISBgZ
	Cjj9+R8ndhi4A1fNll14=; b=ZAY7PV3wsfRq0SxvCQd3SnW7/Q3M3RheLnTXheHIu+GCOPXDt2
	1CDw7b6hCvZeW1Yz0Mm28rWCtdotbd+BjXLnTRUPmJ8OpODfq9vKocSB/YcjOZ3y3pQ6INYPPS4
	zBJ4gOFHI24zTPQ6cxD5iMMk8fkKaM0BwyhHeAYKyxfEDD07Xz3Fu1FvGSd46HssP6QzdBA3V+a
	ButxC8rgtYQutYfJLTqqDZPC3dI3Q/mUhCa22yJzQPUZz+plS88/ZIToN9RSiYbuBFPAVQr0rO+
	OISjFibHehMy3sERcL0oou8Qvj9lwk1Zp63cQdTQr531TJlwiQNOTE2x+Wc8Of208fg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1757670832; bh=QYYDiAvJwYAanrg9LtISBgZ
	Cjj9+R8ndhi4A1fNll14=; b=G6Jdmu3shhEonaVePuMWSqARygW5kBVrcpEvnlzQ6Hkzeou3hn
	KYDkerr/ev93sWw5wGH5zFXc8PQJJWhZgVBQ==;
From: Gladyshev Ilya <foxido@foxido.dev>
To: foxido@foxido.dev
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] maple: fix incorrect rewinding in mas_empty_area_rev
Date: Fri, 12 Sep 2025 12:53:30 +0300
Message-ID: <20250912095335.1225247-1-foxido@foxido.dev>
X-Mailer: git-send-email 2.50.1
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
-- 
2.50.1


