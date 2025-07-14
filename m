Return-Path: <linux-kernel+bounces-730646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BA3B0478D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B91C7AE8A0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A241F277CA9;
	Mon, 14 Jul 2025 18:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Fbrh0eF5"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467F4277035;
	Mon, 14 Jul 2025 18:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752519151; cv=none; b=saGJdpFlwYPfRWhGxZZAyI00ADVbRGyvIA6k2fYVOtLYBdgRLL6WVXMFa3lKTIOuviuZtdNxFx0oQTJGmvW7Y1Qgvv68Wdo0402cZR3dBH9RUBY25kgC/UMifBXnYkMb5eDyyb9lIQ1pnKKVw3TA4KuDlxO2ILYpUIJmbmyya8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752519151; c=relaxed/simple;
	bh=U5mSk6Tmn99cFc1lFU5MvOtbQAzNFsG4TN70oXffbE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iFFnsca4zQhI0hxplu4ySxqf/sHQwQhk2OVX4sLkkGqYA8jWW1Z3fMP/x+2+VG/63rvgdufR+uPyinEQt0Brc2kTT+iuMF+Q2n+gV40u7Bj3N2wBNklHLIrdCwo4qQJv8aq/MNbvKpCjx0XC+k9nzG1kwbeg6JPEutrkwJz4uN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Fbrh0eF5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752519147;
	bh=U5mSk6Tmn99cFc1lFU5MvOtbQAzNFsG4TN70oXffbE4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Fbrh0eF5KEi7IRjO19W6cuGcNNEal5ypIaIVb7JXnemgK/5JKKxXH9b7yoznhB4Jx
	 Tar1IqgEJL2JxUo3vMAcgg/8fTM/78vOPYA5XrlE8rXBaL1ZYelR5HQUITAH0WDTrq
	 6tnMezAn9svbtgxDhDHL69sVXeqbEEro0jSkJJsVsUEv00FjXjMVUFeZ1Yx41xSxO6
	 XYRVdQHC0NZn84KnNcBSM5HcOz0po4N4cJhOjOlZqWY+xL67OrbDWasgkwMrJAvRNt
	 r80+R9+7iiDHwWlZXWs0NWjLdjYfxUB38MPx37IF74iiNwI6XfGmS4XeOvz3ehVP1X
	 bx3gJrfeHrRkQ==
Received: from [192.168.0.2] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4FDB017E1301;
	Mon, 14 Jul 2025 20:52:25 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Mon, 14 Jul 2025 15:52:05 -0300
Subject: [PATCH v8 2/2] MAINTAINERS: add regulator.rs to the regulator API
 entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-topics-tyr-regulator2-v8-2-c7ab3955d524@collabora.com>
References: <20250714-topics-tyr-regulator2-v8-0-c7ab3955d524@collabora.com>
In-Reply-To: <20250714-topics-tyr-regulator2-v8-0-c7ab3955d524@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2

Add this file to the regulator API entry as requested by Mark Brown.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0c1d245bf7b84f8a78b811e0c9c5a3edc09edc22..e37c0fc523964171ab6a9bc59f155b6bf1ab79e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26525,6 +26525,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
 F:	Documentation/devicetree/bindings/regulator/
 F:	Documentation/power/regulator/
 F:	drivers/regulator/
+F:	rust/kernel/regulator.rs
 F:	include/dt-bindings/regulator/
 F:	include/linux/regulator/
 K:	regulator_get_optional

-- 
2.50.0


