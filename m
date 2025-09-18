Return-Path: <linux-kernel+bounces-822959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0134B852E5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA521887BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2933C3112D4;
	Thu, 18 Sep 2025 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="adoC7AD5"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E552730FC11
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204505; cv=none; b=C+Y0u9F7K/iypoxp7NPW1oktEg5fx5ohkoR/MRkPvPhMdMXtaSjfbPKWKaV/YLxCp2qXE5L9lom+0egrmeQVYlodsq+QT7uaFBskqG06MzfI4t6Jrmqbg+I3zdT6dcHuscXej1cpXS48keV6ADnMNsJBHi+SM9uZW5eJTvZiT7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204505; c=relaxed/simple;
	bh=dhSj5aiahwiYdFFl5/shojEybePkO3Sigwj69jpKbBg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TcHcilAM6lSYlNx/FLjYArTRTfIclmBUO9RCuDHXQBozRXN11MYZSMODwnYIbdaqGmtlH+wH3fcc1clxR/bvSSVH3wgLs+gIXl0wk8/XCxYf+PwitXcbc0Wc7ZXa3bFbA7j3jOvKLC6yzrTMzUebNpZyphSg4GInUDE0To3EG3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=adoC7AD5; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-62806a204d9so1004405a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758204502; x=1758809302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgRqLSSOT3PxiLx5xxJiQMGC6CiLApOU4Ty9j4Na8zg=;
        b=adoC7AD5Nzkd61+sY+b6bszVqO1E26wHEHPnfqtePgQCf3fo4+PUmTNcDmUsHxddUn
         B2+T3nw3Lbrtv9JcjsDr5JbrAipfNNjLspgcqrMqz+yVK4uITSywaD6jHBNf9MfSqTIg
         lu3z6rk2Eojn/R/+DbEUB3iauCfA9nzPHa0PcQpK7uj/nY9nXZHML386DTcBjecVXTwz
         iDg729CBj7ZbwtGpSKo5mA1yWMFRk+aV9NotrcFE9zwb6f1Ag/WtXV5ZhuETY5/H6FRQ
         tifWnlx6aTIrEVWZfTchN+XszgMeQqQB5GteCdMVTx6aek5VBYtpwok9Ir7Az/j1ZERn
         lWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204502; x=1758809302;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DgRqLSSOT3PxiLx5xxJiQMGC6CiLApOU4Ty9j4Na8zg=;
        b=a3alxLF3wXsGVfs5Va36dXl2UVodtu/KUSvfIIf6Vcnngao8eMR6jddcKTAcArSt+o
         7YemHSrEkurFEgkn3x9Hu9u1KOTz7+FcHj5UwmO+gJv9e35cjFGIKKltGeWE2gokk1q4
         QnU5D9IeH8xmEFb9Fr80GHG5uYwFI5SRa1LbwQn3ci3ulgkWrre6JPmgs3e0MoQkzrED
         zCWSzlYx9eQcXra8DaUR2leB52UvO4aAXrDVt1eC0R7ag7aI7qlQ6N30BJO+Z+FeNu9w
         QWcCQIn6IFFTfQIai5YlwqH1lEebIpLxsMQUJD3EzTCNwLE134/YKnxs8U1Wek6En4yO
         yiVA==
X-Forwarded-Encrypted: i=1; AJvYcCWlEHVtbktZesvQIvsYo8PikqPtOD1pp+4yaKr9cpr/ulK1XnUdLJid+2dPRnltYGvvSinlY1joPSneY54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0XdxfaOZ3rhdOuvs2EjognwvYg8sU0Rb2tnRIlZ/ZSnyQaLYJ
	WWEs6a6JQr9KV90Q2vdsonyajN3V8yUWS5Vog0g5DGmkIJ+C8SW3kdEXregnwMCXNnW4CwvOQBM
	kocEa+49uiQ==
X-Google-Smtp-Source: AGHT+IHPVGSdrE8o17sF95aDg0BJq+Gm5S9XjEdsZl4DGTYeID7CtPhrC3cVgG3JYaHRggbIvqDrfyHMNHxp
X-Received: from edt23.prod.google.com ([2002:a05:6402:4557:b0:62b:a7ca:c421])
 (user=abarnas job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:848:b0:629:7973:e8b1
 with SMTP id 4fb4d7f45d1cf-62f83c32c0fmr5545831a12.7.1758204501828; Thu, 18
 Sep 2025 07:08:21 -0700 (PDT)
Date: Thu, 18 Sep 2025 14:08:16 +0000
In-Reply-To: <20250918140816.335916-1-abarnas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918140816.335916-1-abarnas@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250918140816.335916-3-abarnas@google.com>
Subject: [PATCH 2/2] powerpc: pseries: make cmm_subsys const
From: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Because driver core can properly handle constant struct bus_type,
move the cmm_subsys to be a constant structure as well, placing it into
read-only memory which can not be modified at runtime.

Signed-off-by: Adrian Barna=C5=9B <abarnas@google.com>
---
 arch/powerpc/platforms/pseries/cmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/=
pseries/cmm.c
index 5e0a718d1be7..913642647fe9 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -375,7 +375,7 @@ static struct device_attribute *cmm_attrs[] =3D {
 static DEVICE_ULONG_ATTR(simulate_loan_target_kb, 0644,
 			 simulate_loan_target_kb);
=20
-static struct bus_type cmm_subsys =3D {
+static const struct bus_type cmm_subsys =3D {
 	.name =3D "cmm",
 	.dev_name =3D "cmm",
 };
--=20
2.51.0.470.ga7dc726c21-goog


