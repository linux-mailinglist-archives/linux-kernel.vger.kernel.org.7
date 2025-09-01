Return-Path: <linux-kernel+bounces-793974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C25CCB3DB07
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60DB53AD066
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B7C25A659;
	Mon,  1 Sep 2025 07:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="r4O/9QNQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gtBrnzWX"
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD7C1F16B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756711844; cv=none; b=gZySwDskY/mc1Nl2ZcqBBY2+da22anZotnOGg2x+CheDtlekBS0zuHkyp8ru+deU4azpzB37GagMa9jAKQgM6lSbALZjLyqYAME05EWMEAetZ27MLW7iJFVnZVKmogJdKEAWt9YYx03094oe6APHUsSosayBnFysm02+EvsMc7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756711844; c=relaxed/simple;
	bh=fCl1OJWst0doBUXz5EoM/vsthT5itOxtexrKclhgl0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SqCvGssDG6lIB04dXFE+ReWA0Wl8hi/KeeT29GOgvy8WsXR2csNYeqg3ejLi5kM0WRzhGIMKZRz/LRkkhgxfF0w9x46v1IVUuheb9/CSmRP5SeiepjBf51BGvT9UJ2wyvjLTGIdnvimib9l3OpNOE8arZeT9jjMMpi13ZXvR/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=r4O/9QNQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gtBrnzWX; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C30701D0021F;
	Mon,  1 Sep 2025 03:30:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 01 Sep 2025 03:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1756711841; x=1756798241; bh=MQ
	M2CXrOuQx3SbmQ7JGm5mVY0OdHZxfgvfo3EDggrhU=; b=r4O/9QNQFNLCsutUlH
	VcQx0col6J9sA9+vv0L1jtSvoCGEzgI2ulNCA57TmXXqcsJyNn+jfTF7j4bqePNa
	RIHNFuzLtU3KnNr+DCn6FZApocm/WReSUQUDIwDKdRT0SVKXcdamHjW7cFNRR8iG
	3AHtcSiy3fCLq/HUEKo8qfOCJJbNl+mDPD1YS+8+WCdplEQv4Kmf3ND+21NmCE4h
	aSmrxkT3itycPf/FzOD/YPoilpb6SK4ZWQTDFiEyv+Hgs4WjFglN5FexfzQHwSDT
	PCFJEHCEGxbprQKuqB3p2qP9UyWjBr2tGdGUkij1xOVf1aIzqJuQYivAjxJ+jzcS
	/epQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1756711841; x=1756798241; bh=MQM2CXrOuQx3SbmQ7JGm5mVY0OdH
	Zxfgvfo3EDggrhU=; b=gtBrnzWXBhB8jUj9g5kyo5WhkiY2zwS2Zevo1XModGj3
	gR0wNAkYwVIQA+OUFqyi2EVoUDdnVsAKPouMa1pAHDij6kJCnXo+r5mRzEKRqN1K
	5UPz5KNJ2Rtrc+VEdrwD8LtvsnZYriqm81OOzImSBvztfiqPIjFzqnnIWrf8X1im
	LX4DHua4+lx7eIml5h26+biZVdJb/61FG/6/6kjAwoVnvNpexUcWjovoASmMAZzj
	xGDgNqiG0efRGfyAnClHmcGIaEpv3f6zemTCNMpNq2v9hMFGMFSTuNkszVqv2Skk
	7QUX5HY2D8T19vW960nYWBT/YQJnwMbWzamMc1rkPw==
X-ME-Sender: <xms:oUu1aP4MnrnhYgn4_eBg2d1Vxkiy-6SvwsygWHreKVz6n87VYC8WcQ>
    <xme:oUu1aAZPMunT6ODESsHXopod0R3SE6CJkZq_NofKKkwD1Z-Bz8LIf5hnfbFYf_vCK
    YmdcxEiAtPYry_Cj_g>
X-ME-Received: <xmr:oUu1aM4zlBDLPE-MPpI2rDkGlU1QMul9EyKfXvQGtQtrZckjPASrgiUbK7kmZxP2ffRA-Nfr99SQA0NSC859gpTdRvRNTfi4k77Fgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleduheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgvucfi
    rhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepgfffie
    ffteeuffetuefggefhgfehtdfhkefgtdejueeuvdevkeetveevvdffkeehnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrghurd
    hnvghtpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehjsehjrghnnhgruhdrnhgvthdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihf
    ohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehluhhmrghgsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehsrhhinhhisehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:oUu1aLDfotD0bHkWtI6GC3QqyWC2hD1NfuYxMytyXkkXshcD_bpAtw>
    <xmx:oUu1aKe3jQQJJfpSl0ViOf9486-jDOjQDr93YCdzhs3c9YajEjuc2Q>
    <xmx:oUu1aCKEhLlFKCXz-_HrBkXU5SlQW-xLMBAg5IFx2bUvmCXEihUgng>
    <xmx:oUu1aN0P7E6srUNvlibm1dn4cUd7DyLawUg8kLYf73Ge_omJ5vRIDw>
    <xmx:oUu1aLNCJ4TNcgdWXWvhDWDZS6P7wTwJXEOHbfey4tWS3GJr6OvBNCk2>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Sep 2025 03:30:40 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Mon, 01 Sep 2025 09:29:43 +0200
Subject: [PATCH] nvmem: core: Fix OOB read for bit offsets of more than one
 byte
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-nvmem-read-oob-bit-offset-v1-1-b610e18cdd3c@jannau.net>
X-B4-Tracking: v=1; b=H4sIAGZLtWgC/x3MPQqAMAxA4atIZgNtRUGvIg79STSDrbQignh3i
 +M3vPdAoSxUYGoeyHRJkRQrdNuA32xcCSVUg1GmV6PSGK+ddsxkA6bk0MmJibnQicFrb7gbLQ8
 ean9kYrn/97y87wdTMWahawAAAA==
X-Change-ID: 20250901-nvmem-read-oob-bit-offset-dc1c2f39af6c
To: Srinivas Kandagatla <srini@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1625; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=fCl1OJWst0doBUXz5EoM/vsthT5itOxtexrKclhgl0I=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhoyt3vNb3TqP3vRRWaEmdWgZ78NlgmXBYaKdvWrzd9SfZ
 +sPPCbQUcrCIMbFICumyJKk/bKDYXWNYkztgzCYOaxMIEMYuDgFYCJ62YwM8/5ryaW0qq70KGLL
 Kk59o7hulX2bTe2xV4Fnzk/T2jxvKcP/yHs7n7sHcBSeXf/17dFPtiet+TX4Qrkl7j1TW3pFSzK
 bAQA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

When the bit offset is BITS_PER_BYTE or larger the read position is
advanced by `bytes_offset`. This is not taken into account in the
per-byte read loop which still reads `cell->bytes` resulting in an out of
bounds read of `bytes_offset` bytes. The information read OOB does not
leak directly as the erroneously read bits are cleared.

Detected by KASAN while looking for a use-after-free in simplefb.c.

Fixes: 7a06ef7510779 ("nvmem: core: fix bit offsets of more than one byte")
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/nvmem/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 387c88c55259541446901f0e539bbb0dd8c4c3de..19be16943ee66e845860192b8f008539873f6f7f 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1618,12 +1618,14 @@ static void nvmem_shift_read_buffer_in_place(struct nvmem_cell_entry *cell, void
 		*p = *b++ >> bit_offset;
 
 		/* setup rest of the bytes if any */
-		for (i = 1; i < cell->bytes; i++) {
+		for (i = 1; i < (cell->bytes - bytes_offset); i++) {
 			/* Get bits from next byte and shift them towards msb */
 			*p++ |= *b << (BITS_PER_BYTE - bit_offset);
 
 			*p = *b++ >> bit_offset;
 		}
+		/* point to end of the buffer unused bits will be cleared */
+		p = buf + cell->bytes - 1;
 	} else if (p != b) {
 		memmove(p, b, cell->bytes - bytes_offset);
 		p += cell->bytes - 1;

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250901-nvmem-read-oob-bit-offset-dc1c2f39af6c

Best regards,
-- 
Janne Grunau <j@jannau.net>


