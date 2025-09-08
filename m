Return-Path: <linux-kernel+bounces-806248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1A5B49410
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045C1188C819
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79408313E21;
	Mon,  8 Sep 2025 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNLTRDO0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D932230FF39
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346156; cv=none; b=Eoq0gtfVkcLwnb+ATUery/6tQX3EkWYmZ9rZDXbcRKA+tLaRthKIhW6dVhQg/YdbWgmrjajF55D+rvDuXkVgcYcGZPZPu4FWF05fInJfkm9VfEPw5yMc6Yl6qFNovkEXyAXRzezyAdqkBahsxAZiRvxAzjemef4AIqc1Z19Miwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346156; c=relaxed/simple;
	bh=eXbgX0A48sO54B6uJSzEg/a+xGkMY4dc5ZXyPrbO1ec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o9HNfkExit1Ra3G6OfIdtD8oMRP40TqpFu6LptOuBbSOrg7jwNGNcRdKqbRk6wB5Z3qFU9gyuNRlntowQRlRvsyUPr3/x/CLsjQFFLbF2Uk2G/fXuXb22HyfxAgrVNU0BeajX6fEoYZ7PpjlOxZVPEKBHiDqWMefrUgm8J+yuUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNLTRDO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBE8C4CEF5;
	Mon,  8 Sep 2025 15:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757346156;
	bh=eXbgX0A48sO54B6uJSzEg/a+xGkMY4dc5ZXyPrbO1ec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fNLTRDO0AqUVSrD7dbA1PfjpK+UdipNbg64hkJJszkoDNOFQ9SsmA+ZZcw0y+9e1O
	 dx4hBbWwRqi24hWaMzevjdVfwuRB0+iRQxBYxHh/jSrGAgGRTn7anX73cpd7wOtoNs
	 juvtoXFNMe6zMiEMYAV2C4fy5Fy4wmGL3EInvZCgBOsear5o6PrfP1fNslRPnp5hnT
	 GkBVmUM4wdkA4GteK5/Pfbio1YDJMX/F6hkPuUPJxXHiuX4TUt3C3ZMxY38S5zazn9
	 x11eBYNJxKZYubQnFMirB9VehYbVoM8DINone6mLNBC3RBBnCRq6C6RSlZYm6xS0Yc
	 6gWmSKpDzNHrQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 08 Sep 2025 17:41:59 +0200
Subject: [PATCH 3/3] scripts/decode_stacktrace.sh: code: preserve alignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-decode_strace_indent-v1-3-28e5e4758080@kernel.org>
References: <20250908-decode_strace_indent-v1-0-28e5e4758080@kernel.org>
In-Reply-To: <20250908-decode_strace_indent-v1-0-28e5e4758080@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Carlos Llamas <cmllamas@google.com>, 
 Elliot Berman <quic_eberman@quicinc.com>, 
 Stephen Boyd <swboyd@chromium.org>, Breno Leitao <leitao@debian.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1502; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=eXbgX0A48sO54B6uJSzEg/a+xGkMY4dc5ZXyPrbO1ec=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL2/UyxDzp6QrhS/0Xl9mT2gATbvyXzr5+pcyn9ayC4/
 cy258bnO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbSrsTIMLG4J4WFi33FNd+0
 ptqMcldeXsZ1W21Vm9TWHrjGc++aKsM/5drTbK9PPjBNfly51oL3yJnpEX8E84t3zUs+sdN+v74
 4DwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

With lines having a code to decode, the alignment was not preserved for
the first line.

With this sample ...

  [   52.238089][   T55] RIP: 0010:__ip_queue_xmit+0x127c/0x1820
  [   52.238401][   T55] Code: c1 83 e0 07 48 c1 e9 03 83 c0 03 (...)

... the script was producing the following output:

  [   52.238089][   T55] RIP: 0010:__ip_queue_xmit (...)
  [ 52.238401][ T55] Code: c1 83 e0 07 48 c1 e9 03 83 c0 03 (...)

That's because scripts/decodecode doesn't preserve the alignment. No
need to modify it, it is enough to give only the "Code: (...)" part to
this script, and print the prefix without modifications.

With the same sample, we now have:

  [   52.238089][   T55] RIP: 0010:__ip_queue_xmit (...)
  [   52.238401][   T55] Code: c1 83 e0 07 48 c1 e9 03 83 c0 03 (...)

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 scripts/decode_stacktrace.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 0c92d6a7f777e1b2d5452dd894a13a71e3d58051..c73cb802a0a3fc6559c5f53ff844e5cc6e433615 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -242,8 +242,10 @@ debuginfod_get_vmlinux() {
 
 decode_code() {
 	local scripts=`dirname "${BASH_SOURCE[0]}"`
+	local lim="Code: "
 
-	echo "$1" | $scripts/decodecode
+	echo -n "${1%%${lim}*}"
+	echo "${lim}${1##*${lim}}" | $scripts/decodecode
 }
 
 handle_line() {

-- 
2.51.0


