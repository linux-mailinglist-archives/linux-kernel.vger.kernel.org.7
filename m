Return-Path: <linux-kernel+bounces-898111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80763C54694
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 734954E2C21
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FD929BD94;
	Wed, 12 Nov 2025 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/MahNBP"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC9029992E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978306; cv=none; b=P5WImIL5x8axD4rPXohbtdNgzLBui0PNClPy1BOR/oNZ2o5jlguxxDUqabOwF2BhqMjQ5CCpAJ+Fa3bR2CklVWE+58W/IjeIrdI/4HY3aE7+ff2Gnpm9IFc75rCtC8FUFpXwI+fLNUNpAIONidjae2Ln0cdJGEkm+ofS33xGla8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978306; c=relaxed/simple;
	bh=7m4DvriM37qRnM2FSfuXRop6IHSnMXPsNmSBQ7psrMw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R1MVZnPc18uOKEhZ+AUyuJRKZD/9g0nP/YK8l5QYSzTTg5L/tjeCMMMBdOjehZObO9ZPLRQ+8cVTNAu6FbEN7l24s8UyA+8qe2iDIQctPo1sJrrp+aCKtYR+2n69VyrIKdzgPF4fp4WcPt/hf79Q746Vv+zxCcmFrK1BJ+v9FgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/MahNBP; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d71bcab69so887267b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762978304; x=1763583104; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6hGzcOlbbGbyI0TcF5Sp7hYfpwvnrcTw/LD+RYYoy/4=;
        b=g/MahNBPFEtaLOeijx7bqX1ZdNBVi+DrWo7YM51eCpN52sXCGnzj71E7oLQGUb+L7C
         dwvvKIIO6zDb1V8lA86WwrYc+7A7shgOpR++cyD1YR0csXwozwbU42Ny7+y/+EtkyiId
         HqYyxtomjkltGxu0UmlV+pcSD1sEa2Mh+ofaMScy5FccmUmyphfyiNaMEUjbsHC1Tu+4
         d7N7rQSIeXnT3BuhDkrWR6z6jsc0Aj88xGxz8dyGG6rgE/TKS/flH/2eqv8yCJLEaxz8
         sjnfHQluMqPwOVdQAlqF1IVcLRneoc+euNXmAHS5Md/MkRlsCJspCiVFIAMV0eSU7227
         mIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762978304; x=1763583104;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6hGzcOlbbGbyI0TcF5Sp7hYfpwvnrcTw/LD+RYYoy/4=;
        b=SKrAHhn/NhL2XDNieRlUtX0qr5dZxWTeTIGCOa+d9YhmD28/QBMwKGzS1ELTYQK/rj
         N1kmX9Xn9tUUv8tsyqLS+toOGuQpmsRF05XvUvi98gHB6gnmxD7zCmDzicbRinVgdCAB
         ExriEQ4Xc4+MvflEew82F9wnLG5sch+VIqk4vIupu04nv8TNU4Qsq7PgKhqnhx7wed2q
         Kb+KoJxXjHq1129N6lS0SR38U2J11mvEly+T6o9cl3yaiB7pXWqHxGI4k/SpB/Ad2tQA
         SgKGLgt0z2dTKukY2XgTgQcAf6ezwxTn7OPVcBstv80cmt3Aj9CxiQFbf4uphDTpm2JS
         /Lzg==
X-Forwarded-Encrypted: i=1; AJvYcCVX+5A5y+nvFH9/fh/U1vArhye98ovwkaPsfzP3eGMDZBI0TGJTDLnc0Pxaka1Ox8GI/Ey1IM8B2OoCyEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrOC1HIfHu4j9p1KQMKT7HSH2O62wkBIspyIxcII61DIapK59w
	WNIHwj9HmFdszbfUkFTPw9IGtkYJZzdDaIg4GyW/Dvh+ydM5XzJjuArj
X-Gm-Gg: ASbGncsjfOQjvK5lRsNQ6XEupuXF6WrYWLxtQhztDI7kola5sNhfibvduKIStTLkoM9
	68Vkyuhfw8KBpjiNUO6+erORjCIawDg+oirWQ6ZKX6gf+bgyAiJYus3fRQGcj0XrhErXRcPjCcV
	9/oDtmsRyTZwowxZju21B7diVLr2qbDJJEoAYleWDgroWNTzV/ZIlwG6q7r9APzbO5ZtDPjYLdi
	/+jwvSxPNzuKwQcOlowYnjQcGaGTPIp6b+A7Wpe63lUWhv9JPoGliz4gSyS/X071sKRZn070e8f
	HuGv+XBLqwwUAd242Clp8LQMRO3BXpvWQ9ZicZdGuDDPIQFm0nYIKRwxJzea48E6mhvoPRxjH9o
	C8ujYPgvRYkk92sLSTmx0WnNOhIEIV/k5IFp+I8blON5ZqwYF22QC4HAh7C5PlinlFaov
X-Google-Smtp-Source: AGHT+IFnMVwZQrQnlyfXiO7Q8cJt+lracFM2MlhYoALs/LETA6AshN8NV/9I3iOkkZsZs4vyL6CHKg==
X-Received: by 2002:a05:690e:4292:20b0:63f:2b0c:2d55 with SMTP id 956f58d0204a3-64101b3aedcmr3138897d50.51.1762978304068;
        Wed, 12 Nov 2025 12:11:44 -0800 (PST)
Received: from localhost ([162.208.5.25])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-641015aece9sm1267616d50.3.2025.11.12.12.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 12:11:43 -0800 (PST)
Date: Wed, 12 Nov 2025 15:11:41 -0500
From: Matt Turner <mattst88@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PULL] alpha.git
Message-ID: <4qsa6oyacdik7neohp67y3vvqu2wczxcuqr4bulxuxksga7zf6@6obnf7yg4ccy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qh24d6ljfp7tlqfb"
Content-Disposition: inline


--qh24d6ljfp7tlqfb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: [PULL] alpha.git
MIME-Version: 1.0


Hi Linus,

Please pull a patch to add Magnus as a maintainer of the alpha port.

Thanks,
Matt

The following changes since commit 24172e0d79900908cf5ebf366600616d29c9b417:

  Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux (2025-11-11 10:31:17 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git tags/alpha-fixes-v6.18-rc5

for you to fetch changes up to d58041d2c63e09a1c9083e0e9f4151e487c4e16a:

  MAINTAINERS: Add Magnus Lindholm as maintainer for alpha port (2025-11-11 20:52:04 -0500)

----------------------------------------------------------------
alpha: Fixes for v6.18

Add Magnus as a maintainer of the alpha port.

----------------------------------------------------------------
Magnus Lindholm (1):
      MAINTAINERS: Add Magnus Lindholm as maintainer for alpha port

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

--qh24d6ljfp7tlqfb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iNUEABYKAH0WIQReryEEmoa4pUzLG/qs6yl0DJpOlwUCaRTp/V8UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0NUVB
RjIxMDQ5QTg2QjhBNTRDQ0IxQkZBQUNFQjI5NzQwQzlBNEU5NwAKCRCs6yl0DJpO
l56MAP9Bw3TlMQV8LR0aUZZNL3+8I9pZoke4en39x5Kp9s1KtgEA8rf3UL8m00Rz
hU1MgcyBDvnGiSfRSaQUNduq/Jz1SgM=
=Sq8d
-----END PGP SIGNATURE-----

--qh24d6ljfp7tlqfb--

