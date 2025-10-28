Return-Path: <linux-kernel+bounces-874056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 234F1C156FF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 928CA56462F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE8D340D84;
	Tue, 28 Oct 2025 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zonydc5Y"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CF333C53E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664844; cv=none; b=nCk6cQBKnfLEah1eGN4Jl/swoY4tsLw+9JOQa1R32gzpS9MDP8ThIMS2jldiMFCWUviDzJ+bSJ6jfJkm0xgG/RdUQrpU7pZ3fX2mvqelkknfsLugSSbjF7IOaiws+7mKOx7AEcGuI2hf3o3FOWN6JXFXSp1o2LBlGN5HuxJiCwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664844; c=relaxed/simple;
	bh=ej1af5qJ3lCW5pa9c4MDK9hKV0MJdmAgjKsq9lgpBzc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cKpyI0A/qn82RSJ7FMookicWv6IxGpHQtU8fqsuo3o48KRuIjiNDedyTOf/MMeDtsBEv1JPLm3OvOnCyGLew7bcDrVLpH4b6G/9JrbSoDsH/qwKbWasJmV3DyNNOp70qIShCP2RugWqWs8Zy/YHMsXXQ5J7X410YeOAUgrowg4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zonydc5Y; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b3cd833e7b5so792917866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761664841; x=1762269641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YIWLk8it8FdUh5OPoc3YMgGMjFwqnKcGsN70DXgD85k=;
        b=zonydc5YLFVRLc3W5jPPTnZxfxv6DA8EkVJjrSjSJqn5qRBOLAwNJh37KFoyJnnres
         DMZi93rX4UkDW1Ao3CRQ1nCzd9tazIg8ZkLl4+k0JfIMfu3sbVMMQqJDnYjUq5c0oTsM
         mHsFLfGmM4Th7TASJV4L9JgK3kEpBK3hnGXFu8LOR1PC3R/nM2Qbu/RcwRpccrcI2Pn2
         cFrEGcvs3vu2tJUSqtO7Mg8DEUnxZSBsL3AIaW9UgJFFx+/OXGjx8kBaujl8IAnB1qkk
         BeUR7wc0+dw7iK/sZQYYkjnnHRBvT6cYJxK2V5CcpvSSj2o8FgSzk7QfTLJz2sKbzuiA
         plUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761664841; x=1762269641;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIWLk8it8FdUh5OPoc3YMgGMjFwqnKcGsN70DXgD85k=;
        b=eFbiglV/X+hwPaotbmrLtEFlXRiKOOdG8oY1BlQNys4XjUddFtKocazmb86m7gkDEX
         JZ2Q0UAvwjpNRgg9KY8JLG4TVHplEW66tuJfvQ6aBTR0HNp9WZjNNU/ruYrfSKdqi2VU
         mq7lAvETJAqsdqKRxH2wVXHTD9ZNbQC5hWfQGtTHv8bAOh5bzwdY9pyU3K57NPBlMmnL
         X/Lt7EUox+QbwnkgexnrkU5YKoGig+WnQxoBJbuqx17+A+UDKPVNoAaXGh6t3jwNARfU
         gKocBPKl8SrGfM97w6Q6PKQVsCVdd/T/70sn4tosLRfBishSoJyNcmBRTzTlVN9Ac4lo
         yeqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1WSEEl+RqM5Yhi8Bqt6S9niyOas1kGoYSFbkGSJ6IHPl1HBBK5vARcIgSnwPaZHRaUGQjMmua/CHQgVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+z7SsP+oT/SOanTnBQgqDm5UgcsADEp7YTZdAduzR01TPLR4Y
	8eZ0Qcl25+ICNs9Clyc9DF8hhhBEWjqeNc8IvIubRSRZTYxEwDit84+959fMgm6S9M9Vqg26EPB
	7mMIDjxA0vw==
X-Google-Smtp-Source: AGHT+IHRlIi7iumEViisCh02GxfRIyDe0dn87sMKGGtppytiH5B8AxwzXZp4+VsLTJGi7NohMhbpMoyrXtUf
X-Received: from ejcyr4.prod.google.com ([2002:a17:907:db04:b0:b37:d295:d0b8])
 (user=abarnas job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:7f0b:b0:b42:f820:b7c
 with SMTP id a640c23a62f3a-b6dba56fe4amr441451666b.41.1761664839110; Tue, 28
 Oct 2025 08:20:39 -0700 (PDT)
Date: Tue, 28 Oct 2025 15:20:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028152013.1697585-1-abarnas@google.com>
Subject: [PATCH] clk: actions: Fix discarding const qualifier by
 'container_of' macro
From: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-actions@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Remove const qualifier from functions parameter because it was discarded
when container_of was called. Received pointer had mutable access to
it through received container.

Signed-off-by: Adrian Barna=C5=9B <abarnas@google.com>
---
 drivers/clk/actions/owl-common.h    | 2 +-
 drivers/clk/actions/owl-composite.h | 2 +-
 drivers/clk/actions/owl-divider.h   | 2 +-
 drivers/clk/actions/owl-factor.h    | 2 +-
 drivers/clk/actions/owl-gate.h      | 2 +-
 drivers/clk/actions/owl-mux.h       | 2 +-
 drivers/clk/actions/owl-pll.h       | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/actions/owl-common.h b/drivers/clk/actions/owl-com=
mon.h
index 8fb65f3e82d7..5768a2e0f6a0 100644
--- a/drivers/clk/actions/owl-common.h
+++ b/drivers/clk/actions/owl-common.h
@@ -32,7 +32,7 @@ struct owl_clk_desc {
 };
=20
 static inline struct owl_clk_common *
-	hw_to_owl_clk_common(const struct clk_hw *hw)
+	hw_to_owl_clk_common(struct clk_hw *hw)
 {
 	return container_of(hw, struct owl_clk_common, hw);
 }
diff --git a/drivers/clk/actions/owl-composite.h b/drivers/clk/actions/owl-=
composite.h
index bca38bf8f218..6d7c6f0c47c8 100644
--- a/drivers/clk/actions/owl-composite.h
+++ b/drivers/clk/actions/owl-composite.h
@@ -108,7 +108,7 @@ struct owl_composite {
 		},							\
 	}
=20
-static inline struct owl_composite *hw_to_owl_comp(const struct clk_hw *hw=
)
+static inline struct owl_composite *hw_to_owl_comp(struct clk_hw *hw)
 {
 	struct owl_clk_common *common =3D hw_to_owl_clk_common(hw);
=20
diff --git a/drivers/clk/actions/owl-divider.h b/drivers/clk/actions/owl-di=
vider.h
index 083be6d80954..d76f58782c52 100644
--- a/drivers/clk/actions/owl-divider.h
+++ b/drivers/clk/actions/owl-divider.h
@@ -49,7 +49,7 @@ struct owl_divider {
 		},							\
 	}
=20
-static inline struct owl_divider *hw_to_owl_divider(const struct clk_hw *h=
w)
+static inline struct owl_divider *hw_to_owl_divider(struct clk_hw *hw)
 {
 	struct owl_clk_common *common =3D hw_to_owl_clk_common(hw);
=20
diff --git a/drivers/clk/actions/owl-factor.h b/drivers/clk/actions/owl-fac=
tor.h
index 04b89cbfdccb..24c704d40925 100644
--- a/drivers/clk/actions/owl-factor.h
+++ b/drivers/clk/actions/owl-factor.h
@@ -57,7 +57,7 @@ struct owl_factor {
=20
 #define div_mask(d) ((1 << ((d)->width)) - 1)
=20
-static inline struct owl_factor *hw_to_owl_factor(const struct clk_hw *hw)
+static inline struct owl_factor *hw_to_owl_factor(struct clk_hw *hw)
 {
 	struct owl_clk_common *common =3D hw_to_owl_clk_common(hw);
=20
diff --git a/drivers/clk/actions/owl-gate.h b/drivers/clk/actions/owl-gate.=
h
index c2f161c93fda..ac458d4385ee 100644
--- a/drivers/clk/actions/owl-gate.h
+++ b/drivers/clk/actions/owl-gate.h
@@ -56,7 +56,7 @@ struct owl_gate {
 		},							\
 	}								\
=20
-static inline struct owl_gate *hw_to_owl_gate(const struct clk_hw *hw)
+static inline struct owl_gate *hw_to_owl_gate(struct clk_hw *hw)
 {
 	struct owl_clk_common *common =3D hw_to_owl_clk_common(hw);
=20
diff --git a/drivers/clk/actions/owl-mux.h b/drivers/clk/actions/owl-mux.h
index 53b9ab665294..dc0ecc2d5e10 100644
--- a/drivers/clk/actions/owl-mux.h
+++ b/drivers/clk/actions/owl-mux.h
@@ -44,7 +44,7 @@ struct owl_mux {
 		},							\
 	}
=20
-static inline struct owl_mux *hw_to_owl_mux(const struct clk_hw *hw)
+static inline struct owl_mux *hw_to_owl_mux(struct clk_hw *hw)
 {
 	struct owl_clk_common *common =3D hw_to_owl_clk_common(hw);
=20
diff --git a/drivers/clk/actions/owl-pll.h b/drivers/clk/actions/owl-pll.h
index 78e5fc360b03..58e19f1ade43 100644
--- a/drivers/clk/actions/owl-pll.h
+++ b/drivers/clk/actions/owl-pll.h
@@ -98,7 +98,7 @@ struct owl_pll {
=20
 #define mul_mask(m)		((1 << ((m)->width)) - 1)
=20
-static inline struct owl_pll *hw_to_owl_pll(const struct clk_hw *hw)
+static inline struct owl_pll *hw_to_owl_pll(struct clk_hw *hw)
 {
 	struct owl_clk_common *common =3D hw_to_owl_clk_common(hw);
=20
--=20
2.51.1.821.gb6fe4d2222-goog


