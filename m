Return-Path: <linux-kernel+bounces-822958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 137E3B852C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 368153BDE2B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAD330FC3B;
	Thu, 18 Sep 2025 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UNoHM9uE"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F772D322C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204503; cv=none; b=CqziVRlbuzLAaNQK+LsRYITCjAuXBnwCwXFwkumk7TR9+q0lahMJ5Juwt12+jVs0GZp/Sani/oCwIcyuC8RwwTUhOLuRKEDIAwh/Ag5VMobsof6Ls8HNqj+0B9pW6Wc5dwo5serX5KTQA42DsFGy6bHEtFHw5maxp+idWSBQfDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204503; c=relaxed/simple;
	bh=MhXlAlSwjJHmnnVBfV2DLAeEMickMPuNIqubf3bn9bk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e9ZIhj9AaLFgJJk2+6TeHAdqPgo1LmBFUbj92ybFZJbdfHB15fAcCR9BslPS6zpYDn/TrdnPgZwTOYHGeLyydygob1heI7Gc0KcoQEySe5oQgAFx6ivACEGFZDEKSAbHxB2wn7C99FbrXRtUiccLiRuQ50hYjT9sb7b6DQDsDpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UNoHM9uE; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45f2c1556aeso3821835e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758204500; x=1758809300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QUFEtRr9W91r6F85WMRrAmbGHvzTF7sa9TKGHakTKgA=;
        b=UNoHM9uEVKKtghCbpL/q/01kcemb/erPw3ztmRwkbZeYxtbsX3Cjq9odvYgyADaMiP
         o26B5YYsHt0HYNDc0sZTVVsKP6bHbnVL3/6ai+23JQ+c/oxE1Vx6CRHEw0kXVnAdUmS0
         rLTuVlDoPAj+HOKSEyuVLzR+KVEp4kXiC0BSXEIkN9ZOagfVzoAN9uK77TJ/HBHpe4IZ
         F3fgPRmSvO/WHB/odO9PVYWUmvfIRJQ1oT/v1yK2gdXzbS7Pl3R8spsfC0HXsHk/eL0C
         a9eL2VeKvoGatEbPzj44twAyvJV8JuGt8hErgoGoGaCqfBecltWO3QKCzMWV5/6EgpIR
         PHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204500; x=1758809300;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QUFEtRr9W91r6F85WMRrAmbGHvzTF7sa9TKGHakTKgA=;
        b=YGJguuZK7CyvRhh+Foap93CR8uOkT4bbJ5KmDH6xffV4KRWb2w3OQCtxhJUsHOt4kx
         nbWLOdpImBoZRE0dGw/kzq3Ghg6kNv0doHgFRRriFP4MlXhzW22z8CTHiYO0kjjVgPbt
         7R7oLI4EV3aqWKOzjd3u9gJ/22NjK+8fJVnMSSB/UUL0KAbdOm6tEOSs/J+8yrJOltl2
         hv+60Brl/Z8WJdlzxKHZAasIv42sn2HFEpWcTLRAWztsGRpzobwCaNr31WZ9wPGwe8fJ
         1sKAWQEmACqsGSObv52M7kSxuqx8bSXd+2TnWG88TTwFZBwIedNe7tVd0o5/skZNI36d
         Beuw==
X-Forwarded-Encrypted: i=1; AJvYcCVKpo2xqJnGqrLt6bSd/o2esn8z8cQclLpiQezDbw5epBxlrjQ/lrKOhlbbPtdCOtyMZbLmpnirukc5CI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YywTA3gZB1s29l8nMuW4FGj10zmt5IYxrg37dZw37EAHXcRRWB4
	qV41ihaOG/kHqUY0xuxaGJkzcTPYzzSrvl9wsT15bUGLMbxuyw8f+8Nfp9/2GzfEiJ4yNps3KUQ
	jk9mep32qkA==
X-Google-Smtp-Source: AGHT+IGZDVm+OjJD6pDYCr4LcAR30jCSUr9yC+URoZtgIUA/r6LEJ5AHEpAIi6hdDt5PyOcQbxPbX0y6XYv6
X-Received: from wmqe13.prod.google.com ([2002:a05:600c:4e4d:b0:45c:b618:4985])
 (user=abarnas job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4487:b0:465:a51d:ab
 with SMTP id 5b1f17b1804b1-465a51d15d3mr17853305e9.15.1758204500688; Thu, 18
 Sep 2025 07:08:20 -0700 (PDT)
Date: Thu, 18 Sep 2025 14:08:15 +0000
In-Reply-To: <20250918140816.335916-1-abarnas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918140816.335916-1-abarnas@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250918140816.335916-2-abarnas@google.com>
Subject: [PATCH 1/2] powerpc: pseries: make suspend_subsys const
From: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Because driver core can properly handle constant struct bus_type,
move the suspend_subsys to be a constant structure as well, placing it into
read-only memory which can not be modified at runtime.

Signed-off-by: Adrian Barna=C5=9B <abarnas@google.com>
---
 arch/powerpc/platforms/pseries/suspend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/suspend.c b/arch/powerpc/platfo=
rms/pseries/suspend.c
index 382003dfdb9a..c51db63d3e88 100644
--- a/arch/powerpc/platforms/pseries/suspend.c
+++ b/arch/powerpc/platforms/pseries/suspend.c
@@ -126,7 +126,7 @@ static ssize_t show_hibernate(struct device *dev,
=20
 static DEVICE_ATTR(hibernate, 0644, show_hibernate, store_hibernate);
=20
-static struct bus_type suspend_subsys =3D {
+static const struct bus_type suspend_subsys =3D {
 	.name =3D "power",
 	.dev_name =3D "power",
 };
--=20
2.51.0.470.ga7dc726c21-goog


