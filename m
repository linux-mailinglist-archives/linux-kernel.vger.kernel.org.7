Return-Path: <linux-kernel+bounces-730598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3348DB046C4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9A93B5799
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA73E266574;
	Mon, 14 Jul 2025 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SueZPqaM"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60881862
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752514932; cv=none; b=hFeU6j8b/QLnNgPMMCHwQ8e9C6otUEkK4icExBjIJUzG3kJ6eyk+FBpLURi0FiJfvY7OCKbIEJh2R2QzHC9IqBBU0y783DZK+cjh/MlcF5HY3/kfqOZb+BlHgjEcpA16PaEwpDElqJkm7yD4oAxN5fbaCCVYMGpNRETwIqsrd2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752514932; c=relaxed/simple;
	bh=0JgqA9YHt4TpWiwtgR0dMP2Dgm7rG+QC0iY11YRi0Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNTrOmRF5RQyzOvHXUkAK+7ngsBGHRgBQpJyG0Ni0AfX4PTlmUX9W4qwBKmaDzgVlxPMIGqG/QoknMBmMVbVXJI5aL7KsHJled6UeFi5bvZBtYoU7ySat/G8j93chJFMCdxvThEcK4kKRrXZclPA7BDqLTIZ0uzWI65gxwai18Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SueZPqaM; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7490702fc7cso2810638b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752514928; x=1753119728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hN8YccMgbb6UtBF/LeELrVcLJIBR2bmzofizaUxZUo=;
        b=SueZPqaMvjtmg+E5vornPuI6tUOaoiiHxaYTfs3VZxlAQDylcyO7ajmnBVT+1ENq/p
         d/YsfsCp4+Yy3FBjaAntt/ChALCWQ/h7kJZWbB6bBBf1slIhTVDlUqrniqhfVH0rloun
         x1VFd8H7hdySaMne3jQqOyqGVcecZ+JXE5Iyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752514928; x=1753119728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hN8YccMgbb6UtBF/LeELrVcLJIBR2bmzofizaUxZUo=;
        b=fyV4ZCcE4K00wxJ0IE9mvaquU6yUQSGS2FOW2OmBul+s9INfa4Dqnt8LdB0X/pk7L9
         EoJfA+jf+5a8yifE+AmGfk+hnzh39DUqvQNQt/wyge3MwGwGuyqhPN9ti4GpkMuB/KUU
         bB/Ju98X+byyT3uwxCrLV96qaXMgrZnSCi8Ktb20xkSImjPGC8LGvkB55hp9cYxNP/EV
         t8HpLetpc23opjeAjVnQW6vSK4SgveL1la7To/EirwEyopcj/7k7Y5zAWv51sLu3xgz2
         nHq0bdHa2BXU9Z8mRVLflo/dO6P+VkYgfFJCrw72v241RBClLqMBp4/xEoMXIbLnY8We
         cn+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhSA0/LCXOAr5U3brsi7SS+U9oejQIvo86gmsOC1I42HffuQeJr9NGESuh0nW2aBMw2rxW2rHSAxy8SEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7egOkuSkssnDmJraI0mv5UxxbE3RU3/WHbOvcndi3EHBFElkY
	dOfK+ZzBodmliZ4WJbscdJW+f+ZfOcirQcSgUlsfLgkX+d61fCIXLE3qrNVO4RgyZAFVpdcQFgZ
	/Wc8=
X-Gm-Gg: ASbGnctFmIckLz9Ft4NWgakXGTBaKlDfzGxGe+Ct5tKtgNYwVAQbJmQeRK2My8pAVKg
	FyueinAZToHKlIqgbJkHTHAuupASp/qfxrEjk2A9nTXcrchVKWcGGCeFz9t/6Ayh7hZM2kRj7fG
	z88lbvo0GyzCV+euN/o3sXPLFaDhsk7spFi4BkDUWUmUDed5+skMCqonun7LF5RQECwDNzEKTjb
	m+Li3WkuM0RMy48bDiaMf6hosS9RoL2tXwhm1ZLwqLFImNwND1Pg9Hq1piOkdQjVa+QCCjdSFbf
	Lk5vrP1H0S4oZDKp6t23ht2rle68UT+8lR7KeTWYuyGU/xuw1qvqRFbu2dRnkQEZqhrfp2Loe38
	PaLzkB9374gCMCuh1n57SQvpvNg156ksReu3voB7RHfpEVK1FBBt6UXF+gkN4RviX1A==
X-Google-Smtp-Source: AGHT+IFJWbhaKX1IlERAhaYQA656ilhN6yaRnRQhGHvOyF3CG4JoxpHTiZnkxciiYIBatjiVLEa99w==
X-Received: by 2002:a05:6a00:80b:b0:748:ff39:a0f7 with SMTP id d2e1a72fcca58-74f1c8d3bcbmr17822240b3a.9.1752514927981;
        Mon, 14 Jul 2025 10:42:07 -0700 (PDT)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com. [209.85.215.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd714bsm10475263b3a.6.2025.07.14.10.42.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 10:42:06 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b2c2c762a89so3650544a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:42:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFq2uLq2CTahBjuumXu9cHlSp9tI6fwIKpVwIlAFC/vnxBd393duf0i3Jx+PpjRz/epqVIvp6OgzMN6iw=@vger.kernel.org
X-Received: by 2002:a17:90b:33d1:b0:31c:15d9:8a8 with SMTP id
 98e67ed59e1d1-31c50d5dfc7mr17730062a91.1.1752514925305; Mon, 14 Jul 2025
 10:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714173554.14223-1-daleyo@gmail.com> <20250714173554.14223-3-daleyo@gmail.com>
In-Reply-To: <20250714173554.14223-3-daleyo@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 14 Jul 2025 10:41:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V8Z8Vq_XP=n_YGh2Junj3N4nWwdU7PeWWt323wsonL+w@mail.gmail.com>
X-Gm-Features: Ac12FXwYxUojKbVSCKrTAuLidZaZV_hTeWFSLtqTJMBGCZSvoJjYkTTdNAw6f-M
Message-ID: <CAD=FV=V8Z8Vq_XP=n_YGh2Junj3N4nWwdU7PeWWt323wsonL+w@mail.gmail.com>
Subject: Re: [PATCH 2/9] dt-bindings: display: panel: samsung,atna30dw01:
 document ATNA30DW01
To: Dale Whinham <daleyo@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 14, 2025 at 10:36=E2=80=AFAM Dale Whinham <daleyo@gmail.com> wr=
ote:
>
> The Samsung ATNA30DW01 panel is a 13" AMOLED eDP panel. It is similar to
> the ATNA33XC20 except that it is smaller and has a higher resolution.
>
> Tested-by: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.com>
> Signed-off-by: Dale Whinham <daleyo@gmail.com>
> ---
>  .../devicetree/bindings/display/panel/samsung,atna33xc20.yaml   | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

