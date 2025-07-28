Return-Path: <linux-kernel+bounces-747337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 162C0B132B3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 02:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 836AE3B27E0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 00:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB5D80BEC;
	Mon, 28 Jul 2025 00:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="byVAaXkA"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17D7224D7
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 00:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753663697; cv=none; b=PO6EeHxKnnsEjD5867L/u3xsibNN4wM/tgKfktQtzuW+mCcqbMQQUjmnZE2x9yQ8mppMivoNJFQg7fGq3WDKGnv/8Sc5+BWda6ubinYNoc3TOov89UDaR9ibaRdPQtIArUjOddeFerc7jkaWeayPeBQvp9Kbah3V6csSw5ZW64o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753663697; c=relaxed/simple;
	bh=iIX49tiYzPNTP8eihaWpW/U0hIgo3vaKHykOa9R9yFE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Fhrhpqoh8x8CWtpwmMycxMnqMTlBwSkQcEwkrkKkgpYhPbLDZ8ZiLOl/UzlbPH0W3dDLNJe4qIHrXWr+/CI6z8G8eY84m82Fl2CKYmgTPlHf4VsUM5++rhGerGawMdQz4h4k8nNrn6TMIiX+O3/hK1qNWWKIyY91tx8VRlg80g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=byVAaXkA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2401248e4aaso6179745ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 17:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1753663695; x=1754268495; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/m2yLXtAPbsmvVSwdPJxGHPEjPAoGD9mowpJ03FJoE=;
        b=byVAaXkA1PJQMXSQnYb36eBWEZEJBQ+9sLxRycPMtMUN7RLe8B7Nea4RB2kx9jFXCO
         xGo1kQHC+TsNLt7DUxBZlmiLSiKaBX5LPhSjpJehtiX324tTDO2wg6CDrfnlBtQUr+AX
         wqdnsudSdbqerPxKP6H6XPQyTWaI1Ng010mSzikxROBxgkS4JVyq6uGcHqm0Ryc2EQqa
         NVuB+t7Fn4N9yA9vaG6DkhNW9S+rtzjm10BHGmIG+pNWG3Qa/JFNnpCfK3sJ5SnLMUH4
         fmKcnvL1t9pN/2cyIjB+X4FM3G4AX18lSWG24lSGh4TeBgi9trbvCu8hF+sPZn+tyfaO
         Cg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753663695; x=1754268495;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q/m2yLXtAPbsmvVSwdPJxGHPEjPAoGD9mowpJ03FJoE=;
        b=R/IuSKlDICNBldGsIX83iqaV7RK0O3HFDI+p4/Fhp/AdZ6fOCAoCD41h9Ty51wK+l6
         VWp/j986J6IrGvD6A1MO9Kh37NEhhgy0lsuH55ZZuCuIA/tKu8/9pRSPr1qXXOBX5mFH
         hipW4kh1ex4p5dIeuPgHYKI6CNkyUr1kcy/+ngaX07e2I58wtU2lKWkHF0N+movrdJ/T
         IduUUfsR6d7XpsrqomVQ+jwCeWZRNfPTq32VT4DyIYPhuc3LP28JXiNz2e+0t2ccGD7q
         O6LmjVHiB3UThbPckUv9ScD9CxZ1dcfzFfE8o3qOtaxvDTWj8m4sJ5LdZJig/BFkHBne
         AYKA==
X-Forwarded-Encrypted: i=1; AJvYcCUMCTIOUdbhpas6cBroB5+0zssoNEjY4b6Ld7kv0JAC9ypdNq8M0tFk1E7/B+8IruZy9Bw0MQ77Z/ABb30=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoUp4Vp4Vftv9GMQM8tnGqP2MPi+np5RK3OcLiTsRv87ci5Esl
	N4hcZPgVcFsYKWilGlNCEhI2BXPqfV1uZwbKD2LBVpoV+ZKBWRqXGQTsFK0jv8bR8Us=
X-Gm-Gg: ASbGncvdCCLCjg2KrZLSI4v/Palkpb9D7D984JGs0g+EeInC+M2urnPLDgZVgGzjiXx
	61yqq+bYvpYZ8P5ZK1njYDJxBbHNcc9pH8307/V1oAdTPLcQhiSrGyBOTcrmDThb/PSm5T1QzLN
	oRlU5Y1UVJDTY1wjj/hoE6kKhd5MAkWmLq5t+IQRMQtc1MX4PSzWCGmdx6jMrdmo1zuHSRu5BJl
	6/nXNRKWEzjV63JgBsDTLAzaRi+T9NaGh+At59Va5H5rS0q20tBObIwnn8JNTJjxF3nDqdhWBsD
	AR33i3HsV10wph0mfQyGKLNUUaBD4vg3j4yNrkQlSoH+JuwT0vqNrnuGOSk84KPY/Db0yKYZheQ
	ozRgTGzf0zxpnlw9QbBU=
X-Google-Smtp-Source: AGHT+IGpUSWz2rXiHT5Ls8XtgdyXyLyQSY2jYkIIzKTp7aIQYL/oUdeBjK25CLIA8d4piIBSPhy18A==
X-Received: by 2002:a17:902:f54f:b0:240:1ed3:fc1f with SMTP id d9443c01a7336-2401ed3ff16mr35964315ad.12.1753663694957;
        Sun, 27 Jul 2025 17:48:14 -0700 (PDT)
Received: from localhost ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe536e4asm40996105ad.163.2025.07.27.17.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jul 2025 17:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 27 Jul 2025 18:48:10 -0600
Message-Id: <DBN9W9SJU6MX.F5UH2D1QCJNC@brighamcampbell.com>
Subject: Re: [PATCH 1/2] drm: Create mipi_dsi_dcs_read_multi()
From: "Brigham Campbell" <me@brighamcampbell.com>
To: "Doug Anderson" <dianders@chromium.org>
Cc: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <linus.walleij@linaro.org>, <neil.armstrong@linaro.org>,
 <jessica.zhang@oss.qualcomm.com>, <sam@ravnborg.org>,
 <skhan@linuxfoundation.org>, <linux-kernel-mentees@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250724202338.648499-1-me@brighamcampbell.com>
 <20250724202338.648499-2-me@brighamcampbell.com>
 <CAD=FV=UZqzWd+Ke2sU-z86jnhKhUo8v0ChyKYnGpmx+s7n0stQ@mail.gmail.com>
In-Reply-To: <CAD=FV=UZqzWd+Ke2sU-z86jnhKhUo8v0ChyKYnGpmx+s7n0stQ@mail.gmail.com>

On Fri Jul 25, 2025 at 3:16 PM MDT, Doug Anderson wrote:
>> +               dev_err(dev, "transferring dcs message %xh failed: %d\n"=
, cmd,
>
> Format code "%xh" is probably not exactly what you want. If the error
> code is 0x10 it will print 10h, which is not very standard. You
> probably copied it from the write routine which uses "%*ph". There the
> "h" means something. See Documentation/core-api/printk-formats.rst.
> Probably you want "%#x".

Ah yes, I had based this change off the "%*ph" format specifier and I
had mistakenly assumed that the 'h' was a literal 'h'. I'll fix that in
v2.

> I'd probably also say "dcs read with cmd" rather than "transferring
> dcs message".

Yes, this sounds more accurate. I'll include this in v2 as well.

Thanks for the review,
Brigham

