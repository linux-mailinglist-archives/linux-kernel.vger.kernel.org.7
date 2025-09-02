Return-Path: <linux-kernel+bounces-795686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2395B3F675
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4553A06B4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2EC2E7BAA;
	Tue,  2 Sep 2025 07:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eo0OeJED"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D742874FE
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797564; cv=none; b=A124J78B0yCq8Rj5JmNQsylMdDxp+CFT1FvyTNfFM/hi7rQJBVCZSWsqTGtWCs666oYDh0V4qG+rO9XDW26pYQs+bZ84TP/s25IlrDMhtKbmkiYOpfwlwUSvRj7h2BCjaba7zaBprewe7ozQBXnSWaKNwVmmPydr/HNXDEGnqMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797564; c=relaxed/simple;
	bh=740BcyIhKfKfRRxyo0ai5JUQmNTeZhlHh8EQv6Fx4lY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UA3EhDkszKQsLsxaATmD8BwnicN+oPyy0+Vb4KiVcrLsfqfx62uAWuW2yuA92zL7rbmYgPq9yeFxC58RQ2UnMFo5TyU+mVv3/+6Fa0aKD8Ztv8pf9LFhxSePpxz0riygiZfD6rAmfQPVkfHozgrOZm7SI5d6AuFCltLDddzb7UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eo0OeJED; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-61d0976931aso4629402a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 00:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756797561; x=1757402361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/K4EAZLbBVfhRbNqsGgmHLXOOZw/G+x8hknE2VHBmo=;
        b=Eo0OeJED2liFTBqkMuJV4XF3t+NRZZcZ/usN1BizoUyWtcXg4MiwSe9eGD2Ubyge/y
         TJCaM+19v50LKyvKAlW8WfUJWXvXfI2hm/wak9DVPXcl+RkAZc30F5/IjFuX7L+HF59e
         2Rl1+A63C1SPEEImAGWBqUZQb0tUdCsDZ2rUf3sAroT2vSa2OzP0kCLIUClgMyhR30HF
         8px9pJ+DHY7VhujdpJvCP4NTSYYUR9ScDMC0Zp5fE5jAQgo/5AJUsEr9ZdqtAJ9ODfXU
         GFEK0c914YsfXM65CaSCj0eHpJHA60osNCDq1KCkosiTHwMo5d1BHO4nIBgjyOtPl8hB
         /8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756797561; x=1757402361;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W/K4EAZLbBVfhRbNqsGgmHLXOOZw/G+x8hknE2VHBmo=;
        b=U5Tr6P0uvINZuzi2Yh/F7QP9C8nwiFxmkblutHKKmbttq+LaBjAbkZQ69yNuFbN9jO
         qqCAs6MCtG7jmzUG9gUFq46LPebfdrHQgK0RCvk0igLhbEFpTR3+aZfN1s+L89nD1RP9
         OhxU6XuFhX8zIg4WaNJufSVJ/8gq28gfHD+42i0i/km68ginkIf/OJEaQ4CtY6LO45mf
         Mh68gf24erAm+wn8dVaWxGU1U2dQpLYidrx+GRL9OX3VxwWFF/9eOgEMLegOnNSY95jE
         TyfIpQPgXYxgeP7Jr9JHozhYCBwdN47toUQQXxcK7hvwzu4iNOlrBSeEWM6kagNS69Tw
         4SOw==
X-Forwarded-Encrypted: i=1; AJvYcCWIVoMj7W3Q4CcX6jN1Do3CuXVmJUJvnft0UFzrWgKIICpkAwhSwTCd6WjxhsZ4dqcxA1NzeTDrOC5Hz1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCuaSpoewEaBRmSDiH0pV0u3tNWqIIt9yD2e1NlBtiXq8bG0T9
	PGybJsNihkcwiu8GUbCm6zQN7a76phIACIJbv/oYoTDWea/DRlKvFAAB1KvCznH+k5LHsIG1V0k
	DgDvzJnmXug==
X-Google-Smtp-Source: AGHT+IHu2RMCHU3NLYzXEdHLc3fvO1cupuIIfSxhMcWwMgEIP0sFksi/5BBq6DCJB2k0Nf4r8SmzBphWIWRX
X-Received: from edbfi13.prod.google.com ([2002:a05:6402:550d:b0:61c:5514:9cb7])
 (user=abarnas job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:90a:b0:61c:e9b5:74af
 with SMTP id 4fb4d7f45d1cf-61d270e811amr9136642a12.36.1756797561020; Tue, 02
 Sep 2025 00:19:21 -0700 (PDT)
Date: Tue,  2 Sep 2025 07:18:47 +0000
In-Reply-To: <20250902071847.2330409-1-abarnas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250902071847.2330409-1-abarnas@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250902071847.2330409-4-abarnas@google.com>
Subject: [PATCH v2 3/3] staging: media: atomisp: Remove trailing comments
From: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
To: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev
Cc: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Remove trailing comments in pci/hive_isp_css_common/host/vmem.c.

Signed-off-by: Adrian Barna=C5=9B <abarnas@google.com>
---
 .../media/atomisp/pci/hive_isp_css_common/host/vmem.c     | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/vme=
m.c b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/vmem.c
index aa67638a09a5..547cc480c105 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/vmem.c
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/vmem.c
@@ -161,7 +161,7 @@ static void store_vector(const isp_ID_t ID, t_vmem_elem=
 *to, const t_vmem_elem *
 }
=20
 void isp_vmem_load(const isp_ID_t ID, const t_vmem_elem *from, t_vmem_elem=
 *to,
-		   unsigned int elems) /* In t_vmem_elem */
+		   unsigned int elems)
 {
 	unsigned int c;
 	const t_vmem_elem *vp =3D from;
@@ -176,7 +176,7 @@ void isp_vmem_load(const isp_ID_t ID, const t_vmem_elem=
 *from, t_vmem_elem *to,
 }
=20
 void isp_vmem_store(const isp_ID_t ID, t_vmem_elem *to, const t_vmem_elem =
*from,
-		    unsigned int elems) /* In t_vmem_elem */
+		    unsigned int elems)
 {
 	unsigned int c;
 	t_vmem_elem *vp =3D to;
@@ -192,7 +192,7 @@ void isp_vmem_store(const isp_ID_t ID, t_vmem_elem *to,=
 const t_vmem_elem *from,
=20
 void isp_vmem_2d_load(const isp_ID_t ID, const t_vmem_elem *from, t_vmem_e=
lem *to,
 		      unsigned int height, unsigned int width,
-		      unsigned int stride_to, unsigned int stride_from) /* In t_vmem_ele=
m */
+		      unsigned int stride_to, unsigned int stride_from)
 {
 	unsigned int h;
=20
@@ -215,7 +215,7 @@ void isp_vmem_2d_load(const isp_ID_t ID, const t_vmem_e=
lem *from, t_vmem_elem *t
=20
 void isp_vmem_2d_store(const isp_ID_t ID, t_vmem_elem *to, const t_vmem_el=
em *from,
 		       unsigned int height, unsigned int width,
-		       unsigned int stride_to, unsigned int stride_from) /* In t_vmem_el=
em */
+		       unsigned int stride_to, unsigned int stride_from)
 {
 	unsigned int h;
=20
--=20
2.51.0.318.gd7df087d1a-goog


