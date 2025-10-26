Return-Path: <linux-kernel+bounces-870398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0968FC0AA2F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 15:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59C704E9861
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 14:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D21125332E;
	Sun, 26 Oct 2025 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ge46rBGU"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452A024A074
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761489007; cv=none; b=dQnMWfWGsGhLJWIpnSdJffi3J3SbviLQUAe5fqbGhNMg+VvEq+bYp+glv7eYu4DpGGESiOYeHFHVMzJXhIhn7waHopAMahYKZVveUplBAjTnQG1tccZ6crBzUbAmyg6PhrIg9I4HJgw0qldsmid6foDOPfzVS17W/LakiJUI3Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761489007; c=relaxed/simple;
	bh=ZMBASMVtnBa1PP4cxjX6NifaX9MKgfOlfcgiWr85ZqA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ljnw73yPqolaYQm5/bqLOWWuzvyL8j0SOXGIvmMDe2rvTmXYz5zEiPOUpOXSaKveNbe97OjPhRDcN1pdWWPJRBlRMPK0HGL5yAqroytL29aA4ZISTm9p90iuoT7kiipts8QvEp3GFgumuV8xH9QpSbJyX1srj73ctnWVULvES5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ge46rBGU; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-784826b75a4so42729817b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 07:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761489004; x=1762093804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMBASMVtnBa1PP4cxjX6NifaX9MKgfOlfcgiWr85ZqA=;
        b=Ge46rBGU368OWN2kmYi0CdXtoGzJ62U+I38pRGjNODlU66NQK780PkZ4gwdeA/twBX
         Dspqzb0NCQQDPTrdvz5ww5LtswnNVgYUQYZi+jSKZZ11oeds3bxFhI5MjITiAeF+IAGl
         eo38n0V8fwfG4XbrKq7fav+y64FBNtSPFZIvb1VuVqtsj981yPHeJuwokHWAfaYLweJB
         yeA8aD/qLL9oQDgPr9wtef8KQIf0y8b/huqQiBe40KUMs/sz7W0wWNv+Q4NV79TwfXq2
         AjaqwyRBxgDXiOzEqvWP7Xac8EF/jbMzsOH31x8cCZQ2iMcPUjE5heMMUBcSYKEy7axV
         1jjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761489004; x=1762093804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMBASMVtnBa1PP4cxjX6NifaX9MKgfOlfcgiWr85ZqA=;
        b=sss3n1Bv8cNpX8JV8WadpiXeUQ3WbBRJgAPEtfsveHM1Xmi+8pqTP9y5vntqjHy6ux
         2v3R+MZhoAUhmk9AIdJ5wejXydXmoOj2F4ky4eb+ckB3pWWUekrqy2vHCOiS7vfdMxBr
         k0AvGHd3+T+YJoLUXApm7MGtouYWbzZhWbLv4fA4uefrHeC1Z1oLZk98PnTNG2zvQ0uH
         7EydMpHPpdo3yRYf6F3cuYUJgQpFc4nJfixp8YljaN4ZX5tTZWHq8WS4k7HMvhY/b4r/
         aMqKwtCseHv+7dGaXienFwF/hmXhVY8k3fzPTSONlZH3mvmeVfUY2SrrgVkaU4dWPMfn
         I+uw==
X-Forwarded-Encrypted: i=1; AJvYcCX9kzd05kOkzGvTHbuhF0JIWRcglIL49mKuh6VzLtUebvxeHuG1fUwOu0JnM/8Q6QCEh6acVjEW1QG9us4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl8z0qw1FTY1y9ZvmkIdQnnKcZqwyH5fnQ+9IDL+nzM/VTH9uj
	aQ59hXRDpZqKyckTQfalt6ahaxF0cYZHAaryKe6H+r5UaYezPR2tX0M4myTjm1TRIlHK6gI9qzh
	Re6OG/IZ/6bAN0c5nn++vNXrjeXeIvzc=
X-Gm-Gg: ASbGncv2rJ+k5OLlgRrnlSflId6bMOuOACeYHCZ2vBDy3coajgXLa3VD7BQKEEAjU+H
	VQPRcNA54ehSlGbAaDLDjhk+/2y0yre2jGP5wdSg8oYHGV/Cvs8qi61ehAKTKO580BMCAhzcVQd
	4Ab2ZJNlxMzrgQSWjNWf+IzQKu62dtp04W+GhknlVKIyZAxEzbU1hcB/fuMYCsS34WfHOupiag/
	FnsXxDOG+/MT/4v60isGOK6nXh49CZ9ipQ/4cx2jEphKGCljIoo6mUNBH+UgEfqneg2UXMmIrEl
	NT3Uk97rrY5mHs+gRaStKpps/LjQx6LX89g=
X-Google-Smtp-Source: AGHT+IFplHhxxhepVtWBvu6tNgqK95auQg5sHnU1QHolP/4r4XhVH2q9CWaTT0gnl3dFh8Qxvm/3lmn9BOtV9jwBKEk=
X-Received: by 2002:a05:690e:4287:10b0:636:1bb3:2d2d with SMTP id
 956f58d0204a3-63e16115b38mr22224007d50.22.1761489004073; Sun, 26 Oct 2025
 07:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alex Gaynor <alex.gaynor@gmail.com>
Date: Sun, 26 Oct 2025 10:29:52 -0400
X-Gm-Features: AWmQ_blrLx6Rk-HNpIneEOmsfH242FhjzwfZJDKkuP91hm5_-oofSVpP1XgVjFE
Message-ID: <CAFRnB2U1uvg1vyZe1kDi7L3P4kTFowfOo6Hfo9WJED4qve4ZZw@mail.gmail.com>
Subject: [PATCH] MAINTAINERS: Remove Alex Gaynor as Rust maintainer
To: rust-for-linux <rust-for-linux@vger.kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've long since stopped having the time to contribute code or reviews, this
acknowledges that.

Geoffrey Thomas and I created the "linux-kernel-module-rust" project at PyC=
on
in 2018, as an experiment to see if we could make it possible to write kern=
el
modules in Rust. The Rust for Linux effort has far exceeded anything we cou=
ld
have expected at the time.

I want to thank all the Rust for Linux contributors, past and present, who =
have
helped make this a reality -- and in particularly Miguel, who really
transformed this project from an interesting demo to something that could
really land in mainline.

Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3da2c26a796b..355fee6a382b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22498,7 +22498,6 @@ F: tools/verification/

 RUST
 M: Miguel Ojeda <ojeda@kernel.org>
-M: Alex Gaynor <alex.gaynor@gmail.com>
 R: Boqun Feng <boqun.feng@gmail.com>
 R: Gary Guo <gary@garyguo.net>
 R: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
--=20
2.34.1

