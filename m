Return-Path: <linux-kernel+bounces-874218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 881B6C15BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 359013522CA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E93E34B434;
	Tue, 28 Oct 2025 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e1BndjNt"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31B23446C9
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668214; cv=none; b=pEgz9/Cr1oIjkzROygPIuBAMZSwm5Py5Wj7ImPUtRTX+MJtHqyGNdQ7S1cyvMrfksRkGLEmFplxqwOC2+K3mPGTxxk1VqmHOc01CeS9tF3mrmfM3HsW5YnMJ/ptfaV7greZhgKSicZanOV3FY2USNJLmmH6TTQLK5QNqQQX4kpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668214; c=relaxed/simple;
	bh=9fTJS/nnMDU6irI8BSHwrjtuXvQjuORoPzSm/7H21UQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kgXEG45s+GjTrxYsieWDrcTS/xQV4l66bvex4oL8GXcOA+0IrP8DzDDWjIZ0LPwygxzEDY6Yr5EV7e81ywfQnzdmB8aDOmzMHQny7VhPfRWh4PQzWgnfXY70VowAHr6ed+/FrehjaBaitBU6NXeyQuCa8lxNBZq+yqYylfjmB/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e1BndjNt; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4770e0910e4so20887855e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761668210; x=1762273010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ho6JJQRwGiXKBOt/Alu7bdbMk7B3pL4UhaTJjWAG4eE=;
        b=e1BndjNtsaFwY6XO0cuiTuLRaFXibglMnOuQTayqBdOXRWQwHKF7O/PcsQDIGwZKO+
         lbf5TGt1SJ1TxKaYXhdhRgaqNE2/vlk2aV08YTDwB6hd1Lp+w2rC94C7Uy7keWs1gWwV
         uN63dwaGPOs3od9LtTikWWKlkD86wweeMz6nAaYQphlTe7Xw9mQmV1IFZUlyH60beHEc
         5pc0zueISZ2piShQqiyMF5je1rsKqVbtY82Yiwv4rs12RIg/MQ/xu0zMSoRin9naq/qC
         WJnggF0oklnJzxm+GYIxlba5wHnF2/b48XOpNTALbjH5GDYlMSUffmFYjF2Ov4CyQvrs
         RUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761668210; x=1762273010;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ho6JJQRwGiXKBOt/Alu7bdbMk7B3pL4UhaTJjWAG4eE=;
        b=Wr5kjBTmKnxmIL+lhtiKdN437gnAn4Jf0m56yDdZAgUItcjTvAgdYS35S6u3sOp27q
         FCztNA92LR0xzfqgdHzXGg/0dLAc8s80sbzaF33Hp4vnJzqxcKaSTw2mk5/DlNPi9+ev
         Dyw32NUCJa8zajELxkIt1orkS1DkcLeXFdUlX2luSYlS5VIpv9QCB5EfDKhFIWiOeP8p
         RFJ6CpNfQLoG73DIy35ySK16yhvPDPMJqDyhuisxtUE6U3lBvy5Og2D7G5klSd8vGRjE
         FoIRjENDzMqkjNipC/lEITp4bRJOfNHAKU7ZbPpAf3l5Llt1NoQz5ryfIfRsHgcrxo6i
         irVw==
X-Forwarded-Encrypted: i=1; AJvYcCUi/crdeFJE8jGGwstsXNp7Jm1UuOU/OJBDXcGczy+cNisgywpn3vGG/nEUOG7R9v0kucLeQvEVfhNqufI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWbvd2QWsNCbizTDeIw9r4g0O1CmsCp28ywifySpaPNt63PDkp
	BQba1ls1QErh53QwWYGlD0QU+qQEskMRqvjG2hIFDUbn34ZXvee8/Xt3twE3OgOF+Id4qItWlva
	Qg6QDss6v2g==
X-Google-Smtp-Source: AGHT+IHAhlk02BCJ5Vh9MNlszflfsqyTxmT8WTEnXpCaDZBseldqLR8dNqR6+bg3BKFy28J8Xt8y91Rz4bSz
X-Received: from wmbdn1.prod.google.com ([2002:a05:600c:6541:b0:46e:1f26:9212])
 (user=abarnas job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:64c5:b0:475:f16b:bcbf
 with SMTP id 5b1f17b1804b1-4771e177ed5mr584995e9.14.1761668210378; Tue, 28
 Oct 2025 09:16:50 -0700 (PDT)
Date: Tue, 28 Oct 2025 16:16:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028161643.1727046-1-abarnas@google.com>
Subject: [PATCH] clk: keystone: Fix discarded const qualifiers
From: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add const qualifiers to the pointers returned from 'container_of' macro
to prevent breaking the const promise on const struct pointers from
parameters.

Once you have a mutable container structure pointer, you can change
structure fields through it, which violates the const guarantee.

Signed-off-by: Adrian Barna=C5=9B <abarnas@google.com>
---
 drivers/clk/keystone/sci-clk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.=
c
index a4b42811de55..9d5071223f4c 100644
--- a/drivers/clk/keystone/sci-clk.c
+++ b/drivers/clk/keystone/sci-clk.c
@@ -496,8 +496,8 @@ static int ti_sci_scan_clocks_from_fw(struct sci_clk_pr=
ovider *provider)
 static int _cmp_sci_clk_list(void *priv, const struct list_head *a,
 			     const struct list_head *b)
 {
-	struct sci_clk *ca =3D container_of(a, struct sci_clk, node);
-	struct sci_clk *cb =3D container_of(b, struct sci_clk, node);
+	const struct sci_clk *ca =3D container_of(a, struct sci_clk, node);
+	const struct sci_clk *cb =3D container_of(b, struct sci_clk, node);
=20
 	return _cmp_sci_clk(ca, &cb);
 }
--=20
2.51.1.851.g4ebd6896fd-goog


