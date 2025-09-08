Return-Path: <linux-kernel+bounces-806246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 761A7B4940F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DAEE188F7DB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1479130FC2B;
	Mon,  8 Sep 2025 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aivIXE1H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7344F30FC19
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346153; cv=none; b=EwigQOTviIZFK0OUA9voHr+Tr3CaaRmy4BFK3YZMFJSitY9AQIdJvpSgUxiJj1p/luYUyplJJA1UzsPOwNlouALxLwV5Kv1/GdzI3gXKoD6jetCaeRt5eQAVoLHETOooFJ3BkGLoHj24IHNeV5qrr1loxn8QAija8Tq9YilFHXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346153; c=relaxed/simple;
	bh=HUX79U9sbM5RM/b7aDn1DdwQrXQY0K+KyM3Zg8wGFQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BFICUYI2woTSsMwdgqQ+pNoiStwngDqgT7cOSkZjJrmPY2EHLvRAgllS6//cenxHZs4zENEh/HWVMFqUYD/Sb9mOsKgFtYyUK4wJlUkn5WC481zMzDFSG/vJ5gfnEX7gC4Jcx0JZk6WcyCUSH5pw8uQJJVBMhnLr7zKydxpFvnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aivIXE1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FEBC4CEF5;
	Mon,  8 Sep 2025 15:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757346153;
	bh=HUX79U9sbM5RM/b7aDn1DdwQrXQY0K+KyM3Zg8wGFQE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aivIXE1HmxcYU0GvuBGa6Y9bOpbaKqsQUN5YkewYObJl20spT3KUtijPxbok3TUIX
	 3ElF62QfLuisXjqu7NWOMOLNpJaJXu+vt0mQyuGVaa+cgTB/OY0XJoY744QGReBw6g
	 A/r0n7kymHsqVe/8SBZ0GGWviSPwHmVlnOFLsy4yC0xMlLJLce0ykiWuJMNABxxCcw
	 vewACWQaqfWuBP+yorjDZSUFzb2hhpAXmLbcEHGKzkusWGAjsojcQvzLS3+MQb5mSZ
	 gb61Ckvqkuydjic2cOTxwvFziUW9hW3xnHe0XwN866VZ2yYe43USfAEhhjhI3cC1vG
	 kcwLEFaTLRJ9Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 08 Sep 2025 17:41:57 +0200
Subject: [PATCH 1/3] scripts/decode_stacktrace.sh: symbol: avoid trailing
 whitespaces
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-decode_strace_indent-v1-1-28e5e4758080@kernel.org>
References: <20250908-decode_strace_indent-v1-0-28e5e4758080@kernel.org>
In-Reply-To: <20250908-decode_strace_indent-v1-0-28e5e4758080@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Carlos Llamas <cmllamas@google.com>, 
 Elliot Berman <quic_eberman@quicinc.com>, 
 Stephen Boyd <swboyd@chromium.org>, Breno Leitao <leitao@debian.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1275; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=HUX79U9sbM5RM/b7aDn1DdwQrXQY0K+KyM3Zg8wGFQE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL2/Uz6u8552az8zoWlH1azrNxmzTXjdHOkkrb63D8TG
 ndMvWW0v6OUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAiu2IZfjE/n1j3r+Wfd9dO
 9S0l/7Suvut49/ZgU+NMl4DwdTevB3szMhwVaLVOtHI13GKhffDoBh1fb1nBfVfDtWwWB2xWMJ7
 wnxsA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Lines having a symbol to decode might not always have info after this
symbol. It means ${info_str} might not be set, but it will always be
printed after a space, causing trailing whitespaces.

That's a detail, but when the output is opened with an editor marking
these trailing whitespaces, that's a bit disturbing. It is easy to
remove them by printing this variable with a space only if it is set.

While at it, do the same with ${module} and print everything in one line.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 scripts/decode_stacktrace.sh | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 17abc4e7a9855b10e76acfdb92847e1671d6c2bd..c6b5c14412f0f6f78fb60b0b042d6e22bbb46b79 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -323,12 +323,7 @@ handle_line() {
 	parse_symbol # modifies $symbol
 
 	# Add up the line number to the symbol
-	if [[ -z ${module} ]]
-	then
-		echo "${words[@]}" "$symbol ${info_str}"
-	else
-		echo "${words[@]}" "$symbol $module ${info_str}"
-	fi
+	echo "${words[@]}" "${symbol}${module:+ ${module}}${info_str:+ ${info_str}}"
 }
 
 while read line; do

-- 
2.51.0


