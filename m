Return-Path: <linux-kernel+bounces-844033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C898BC0DF1
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30FCC189EB9B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173292D77FE;
	Tue,  7 Oct 2025 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="STy3dpPl"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6DB2528FD
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759829999; cv=none; b=Hb/03MzQQGIQbds8jGGzQB+YBgwx56Gf3zsNo2haByC6I6FPiVAkqsZdQuKwcqoUgfUrxU1qexrBwyrTmyR3LNd8PGQeGbC6Qzax6DeMPLkaJMKnip7YX2OPJXWcwCDwhCBQE80/5lgWjhAm3NRnQ0qMjnGpNvDCA9zhnQV6GKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759829999; c=relaxed/simple;
	bh=YJ4l8YO6+oXjEOidGVwHWzcVddJ2TcaRCjmIlq6mC5k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ew0q0D62duRur+xL+N2IE3cL4V0OzuD7Z6vN4OI7s3WyJ253kL/yCVjyEgXdLLzecCvWN1EACAms58g+U6LzIEdNN1bS8poeVP7+cIwO27t6LFk1bl1NQV6U39PqEj2741OaxmXusIfT9yFeOrDiUZzLew2IiEtZoB2uvVbqtKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=STy3dpPl; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3ee12ab7f33so3242867f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 02:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759829996; x=1760434796; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FmSwAXOxZKUOz9AOH50gpoq+A3qgk8C+jOU4GTuqrho=;
        b=STy3dpPl9Xhi3iu2LiXEkKDT2Eoont7dMyNDlsZvNuKxu7ToXtBaEy68Sib4111Dsu
         Sb9WepWNzuhRM1zIhM7kO8AlsZDSTBNp4VD1+sNcdGkyAgFHfLlDj6vPg9DBijshI5+t
         cYXBZnoshkgpXj3KG5EZvSXswbdLzvzNbPWQa20kagefQKP2D+GQJJh+Ci4ToOnItVSY
         g3HTZFGCtUdWt9a4SYZuFASc2ZnU0Y32jIeOlc1RB2AKprVswT8f1tlpiABUSOkF4fPi
         lXCHwsr/OgHkxZo19p6lMj9OzhWcYDyOM8C9VDyxSXtsHSOtZZJ/TZVxoFDAfNuzcxzY
         i6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759829996; x=1760434796;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FmSwAXOxZKUOz9AOH50gpoq+A3qgk8C+jOU4GTuqrho=;
        b=hSQLBA4AWUkSfFn8UPF+9cwACJFnjRNAi5ZmeKtYWrWyB5x4T8RoVcv15keJKt4wZw
         0uYp5BFdVKExJuIVbkCX6g1AVD0mIF0mOZrLxwivz6z1rLtyLWVIYf3+wV6A4aUSxVan
         OPNaEtdIv95TV1g/0y14MpjbNqzalTGiR/hBvqKzQ/SlL9bKW0mbWrOnlJ3deaYfglcR
         6wD83bchDggh6ToFtiz4pkwRxYgkl8+Da9+TFoYiIGzl5vKsIbDsGB4bKQ8v5tLYq+zc
         w0OGDphI8l2l5gW4Xc74T2ZOWyYtSmADhHbwbdqo+jddMX8OxL23nvSsSfbGWXm/aKTc
         uUVA==
X-Forwarded-Encrypted: i=1; AJvYcCXzx4gTUQPnjfOevg0cUAb5aov4FPFO8eA9HRl1P2lmpspq/GwBBgE7xHpOAz3kG+sa1C5LfKD99IPrgkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyCv2zkJl/wUMPfNe+lAGjPj4mQbn67BOYUmKo8A8b1EkY5jmE
	4x9tNC/pz1MOSv5h7gmV9To0xHy5bSj+JiJGeDz4PQiM02XP0pcV/lSldawyQiV8+yPPaDfUrn6
	2z64YUC/TWarsZFKKtQ==
X-Google-Smtp-Source: AGHT+IH9mV4n0lSExlu3FWYpv4Mx9IbTkfdC7gum/bBTbtYumGPaxNtiTvGoi4bA+x/MdMJOo0Dus7tFTRbpL7M=
X-Received: from wruv15.prod.google.com ([2002:a5d:678f:0:b0:3de:7346:de21])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f47:0:b0:415:7a6c:6a38 with SMTP id ffacd0b85a97d-425671c3bcdmr9683097f8f.59.1759829996366;
 Tue, 07 Oct 2025 02:39:56 -0700 (PDT)
Date: Tue, 07 Oct 2025 09:39:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAObf5GgC/13MQQrCMBCF4auUWRtJ00qJK+8hXZhkJh3QRBIJa
 sndjQU3Lv8H71shY2LMcOxWSFg4cwwt1K4Du1yCR8GuNSipDr2UShgODpOghPhGQVqjGpwdJ0P QPveExM/NO8+tF86PmF4bX/rv+pPGP6n0QgoymqyzpMw0nHyM/op7G28w11o/IQg1NKsAAAA=
X-Change-Id: 20251002-binder-freeze-f99e23dc47bf
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=892; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=YJ4l8YO6+oXjEOidGVwHWzcVddJ2TcaRCjmIlq6mC5k=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBo5N/qX3xFHhbOaJLoreqfLBGBEG7JYzjxBBPl8
 pRre/Fl9MaJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaOTf6gAKCRAEWL7uWMY5
 Rk3eD/0f8Krqvn+ehSx/aGgx/Z+jrHzHgRtE++NieYt4mvpXcKEPsfvaOKDxwFTVFPV9DV5kzJV
 TstX2/turYRCm0YZCrQ+LiXfudTuXEIyfhNjGQgjqRD8pP8xIlEwidLd8yeMF06a0w7C3IlGnoX
 Thoyo5fR7UubjX04nJMMdeXDBWPhaH+F6xaygp7S3+l4hiWhZjhVT6scfMklKbNoplswK0F0Ve/
 hQqJym3Qnb1beaBHbfG0wMY7VGTYSqr5x90Lrk+SmrI1iHFyzJFjGaFl6Pag0q2O0wRx+GXEaWx
 NjG9BTB3K5y6yNQXJGJXOakaJjyrPy8DXgv5ExRlfI8XJtRAg+4jHyjFZvWzMGAPfcQSDAqCC+B
 lHAcx2JRE6vkg7cAKRAQUExmP0sXGSICxY51yBiNgkN05Y87Xu1paJSGH7ERS0WyooaFOpJU0dN
 08kIETVJ60y6pG9pxx+Ac9B5xUrRTedpgixCofVmK2o1Ot9GLTWY9uHZxRDaviL3up3Jj8YJG9p
 bVooruyZIpqEao4fgCbTP9E7Enqj9y8/gm+G+kf4X6aeb0AlVdD0G8kuny1mGIfLdGbCEIGqrR+
 UdaNbYp56bd4tDTIMeLOuVnZtzNsJ4Do3EnIWkvtbohUCVS2TpYTYSWt5Gyr95sWVQJMYftfaCD +XqNhuEhsWjzvIg==
X-Mailer: b4 0.14.2
Message-ID: <20251007-binder-freeze-v2-0-5376bd64fb59@google.com>
Subject: [PATCH v2 0/3] Fix three issues with freeze listeners
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Martijn Coenen <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

See each commit message for details.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Add fully frozen fix (patch 3).
- Link to v1: https://lore.kernel.org/r/20251004-binder-freeze-v1-0-fb9fcdcf2b73@google.com

---
Alice Ryhl (3):
      rust_binder: freeze_notif_done should resend if wrong state
      rust_binder: don't delete FreezeListener if there are pending duplicates
      rust_binder: report freeze notification only when fully frozen

 drivers/android/binder/freeze.rs      | 18 +++++++++++---
 drivers/android/binder/process.rs     | 46 ++++++++++++++++++++++++++++-------
 drivers/android/binder/transaction.rs |  6 ++---
 3 files changed, 54 insertions(+), 16 deletions(-)
---
base-commit: eafedbc7c050c44744fbdf80bdf3315e860b7513
change-id: 20251002-binder-freeze-f99e23dc47bf

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


