Return-Path: <linux-kernel+bounces-880357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0614DC25983
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A7184F0E53
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A1734C142;
	Fri, 31 Oct 2025 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="txw8bM1i"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECEB3EA8D;
	Fri, 31 Oct 2025 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921212; cv=none; b=Hmw1hyZJ3Qz9Pc0WoLlQcU2aU+yavCi05VLhF2pSH9wDSzgiNJqLbbPqhvrfRNSpKi054YCP7d090F3/bEJ+JHcxOAjT3R9WnJcaV+OHB9OpRR/knd7rghQDPNrhibtjHrS72enT5IhHaX/n7VVoWoIuFnln5TWMSyIOo6GcvqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921212; c=relaxed/simple;
	bh=L+bUO1Dgzo7IE3b4l8K6q1eTKur845NQvpxZqUBJvbs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=O+A49sPDypf/6jVLHTLT43pvRqnKubG89e+jBEaq9ZsXgySfJL8HPILbRnvucTClOCQpxeiQK8Qgy4P8Danw+3uJGA5oxZjJITuzwGtXPVxNPIX2IU3Z7xX4ve4jSwZ3GMUMFnc1S5/65JRcKJBk9sKgUBzzkwBh2vXneNMFXMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=txw8bM1i; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761921208; x=1762526008; i=markus.elfring@web.de;
	bh=NfBHc9OlrzPhoD5qUA+KZdF9mKC2AbjGJnZVNoqMubw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=txw8bM1iWLLqx1XE7A5d51Fvx7oaTTgVe1ooTPCieGqiaFomQbJtczML7qlUbKCd
	 lifhhnIJFmrLIgoE+cA/pAh4K7F1ukAhbIUZIny5VzMy45TQqq0AxOxIH21WeRvms
	 ObURypvNL4jPAqH/3pSM5fUhcv957mtAwcSzyo4ih5fX1U18k/x33L1rrHrDADbA8
	 HGRiaMmXBTAhLV50cHK+zk0lIRt4xlPCj1OHTmra59hi9FDAZat0Ds0GQNNAgV/ya
	 hh720W7QnEctbgNqJOHHFdpPEJJoWl+F79KzzKIz8BncgETF9byERYTL1d2urIWZn
	 zx8iK/eh1hb1Pmsiag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.206]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKdHC-1vXT0V3rR6-00SpYB; Fri, 31
 Oct 2025 15:33:27 +0100
Message-ID: <a8e94921-a426-4db8-aed6-b6e17e88b8e3@web.de>
Date: Fri, 31 Oct 2025 15:33:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michael Turquette <mturquette@baylibre.com>, Nishanth Menon <nm@ti.com>,
 Raag Jadav <raag.jadav@intel.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Tero Kristo <kristo@kernel.org>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] clk: keystone: sci-clk: use devm_kmemdup_array() once more in
 ti_sci_scan_clocks_from_fw()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nW6L0UFjYhMbTb9w7ibhKX7wvUDdoGqZYXctFUXoKkk6q1ZKfKX
 fzT/tmCulrnvvbhU012bp6EuVvp3iOGLX2hk+nXEbIxB4/yTaXTqrKJj4u9nOMRpmQmCEIS
 KT7bQyJ/4T7lpHlUMx7Fj60kejkH+0RQed+g3rpkbaCuJPVFRH0sJLDFjAB3FXYWcCAnxYJ
 j/aQXrcRt9Zi9Vjdl+R2Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9sYAKTqY7xA=;0W7qoLXnS0+onscO0HmHiEh9+Dw
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 31 Oct 2025 15:20:22 +0100

* Reuse existing functionality from devm_kmemdup_array()
  instead of keeping duplicate source code.

* Prevent a null pointer dereference.


The source code was transformed by using the Coccinelle software.

Fixes: 3c13933c60338ce6fb2369bd0e93f91e52ddc17d ("clk: keystone: sci-clk: =
add support for dynamically probing clocks")
Cc: stable@vger.kernel.org
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/keystone/sci-clk.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk=
.c
index a4b42811de55..0c93c83d4776 100644
=2D-- a/drivers/clk/keystone/sci-clk.c
+++ b/drivers/clk/keystone/sci-clk.c
@@ -456,12 +456,14 @@ static int ti_sci_scan_clocks_from_fw(struct sci_clk=
_provider *provider)
 		gap_size =3D 0;
=20
 		if (num_clks =3D=3D max_clks) {
-			tmp_clks =3D devm_kmalloc_array(dev, max_clks + 64,
-						      sizeof(sci_clk),
-						      GFP_KERNEL);
-			memcpy(tmp_clks, clks, max_clks * sizeof(sci_clk));
+			tmp_clks =3D devm_kmemdup_array(dev, clks, max_clks + 64,
+						      sizeof(sci_clk), GFP_KERNEL);
 			if (max_clks)
 				devm_kfree(dev, clks);
+
+			if (!tmp_clks)
+				return -ENOMEM;
+
 			max_clks +=3D 64;
 			clks =3D tmp_clks;
 		}
=2D-=20
2.51.1


