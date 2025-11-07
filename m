Return-Path: <linux-kernel+bounces-891111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D769C41DC7
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 23:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 259CE344163
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 22:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7622FD68F;
	Fri,  7 Nov 2025 22:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J2tcePjV"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15BF21257A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 22:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555722; cv=none; b=eTT9KcOscpNIUx0DH1yVZSJZhdpNhHw/iyEJCoybNF8E9R8wvFa8d0/DAgbPP0MNQS3jW7BhNlk/tm6oLXi6w9wxb2DdF/qp4PdsQs8+376ItmFGZNBF/0TvXdTZTUQST83+3KfiNKICAI4tjU0BiQkTt+zzGVy9x9VCTOIrj5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555722; c=relaxed/simple;
	bh=0uhi3LhN/TY3C+mwMiXw20RS8D8ByJuqO1x49qGA8kk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HsTK7q3J10mrT9TU6L+TpmDmII1kD4zrngYhOdhoadDRM2+PoStFFf8cQd8rGC2EZ8vM+36+4mvEHSecWTZU/BSS3AfOE+QBzKlYlrz7ms5Sa5Vp0lGx9jxdiLvFHb74HJiL2YRR0weYsh2DQt3HbX6IW16Vb359qwDt/vGQRF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J2tcePjV; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b92bdc65593so2032752a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 14:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762555720; x=1763160520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GjKO6SsvgtRfFrPymVYVYJe7CE8EdLLtJ+Kc27VQsGs=;
        b=J2tcePjVTgQU8yN3TDTT42uIVcCPzBbd76sBJXtJJP2daaMybNk63GpFIOi2wwJvW5
         MpKJxCfDylDxv8hwL4uRB8cFSOTjwlRwXLEJqh6kld6ptzwcoZakiej5Rr0NY3Llrq19
         RPuU7HXDA+/n4I49Hi1rvQgEi8yrd15MN6S8wfHdGt8QtVpowOh4iSPGPKomIEEEQTxA
         7/FvsfEXf0qctDsczLbZwQvk7aAG47TxDM7IWkqaaECcVTbBkeFe1JRpnF3jTTVwcAM6
         StFV4rHNfYoUBrzCIJXDmH4UsSdNJ/y+ajOjg5Sxr3j8DAqpYsKBCRZxeYcjdG4E51WT
         LDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762555720; x=1763160520;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjKO6SsvgtRfFrPymVYVYJe7CE8EdLLtJ+Kc27VQsGs=;
        b=Ak0P6iJnIr9PXbgN4K+TmiSnIOTGskeu0PSXpHRg44dMsmBco8x2G0ThtXLl7U2kh0
         FRIMJ6XjV9sW/z1RBm2AAMgJPcNbtF7ZJY0d4gcHGa1z9nkyL1jGcoj7JOwYV96EUbZG
         TXBN7wmbtxQ/3OM8dJBKjwy8QX25AFHOirAhgrxqShZmvQHgw2ckZSxVe06Ler1a6+1n
         raJRkeOqFELxjpQmUINw6iqTc4cTlgrm8xFJSX/scdT7RtX/CTv2kl9pjEFiOgljYEOz
         Y91nKCQHcTTmyzvQ87mim+KPjEMnvDrn0FYtZbT2Cny7fFPkO1Y0WFZmwjpDZ03S5OCx
         h7Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXkUBuBq7thO3x/XH71sbhx7DWcm/3FSXeCNqXK8m5Sw0eO9AUmTePAz2lcJofH5HtIZhtgBosnTQDvlns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtr96J7rJDuaPUT8ZNUgUbyf0HLhPNdOe4rU5gwWpteB2nbrfZ
	kFc7kpeMXThgCpZU5UzyfFraWAipv9/iH6vrtUd8A0FR/IkgVTv0MZdrqKhYuUg3VhB9eTtVPC7
	xS2a3f2pmOfabGQ==
X-Google-Smtp-Source: AGHT+IF7tmvdp0Gv0JXBE1kGSHBBOLUOw5x3V8gLqHS/Xp1dJUgPv8nPcII198KMHEhdHM6xJCUwRJv9meTaqQ==
X-Received: from dlbrb21.prod.google.com ([2002:a05:7022:f015:b0:119:78ff:fe18])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:9186:b0:352:103:dec1 with SMTP id adf61e73a8af0-353a12a90aemr929462637.15.1762555720106;
 Fri, 07 Nov 2025 14:48:40 -0800 (PST)
Date: Fri,  7 Nov 2025 22:48:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107224824.644832-1-cmllamas@google.com>
Subject: [PATCH] MAINTAINERS: add Alice as a Binder maintainer
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <christian@brauner.io>, 
	Suren Baghdasaryan <surenb@google.com>, Alice Ryhl <aliceryhl@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alice has been reviewing binder patches for years now and has a strong
understanding of the driver, so this patch is well overdue. While here
also clean up the list from folks who haven't been active for a while.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddecf1ef3bed..86f4afee0c75 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1807,11 +1807,9 @@ ANDROID DRIVERS
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
 M:	Todd Kjos <tkjos@android.com>
-M:	Martijn Coenen <maco@android.com>
-M:	Joel Fernandes <joelagnelf@nvidia.com>
 M:	Christian Brauner <christian@brauner.io>
 M:	Carlos Llamas <cmllamas@google.com>
-M:	Suren Baghdasaryan <surenb@google.com>
+M:	Alice Ryhl <aliceryhl@google.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
--=20
2.51.2.1041.gc1ab5b90ca-goog


