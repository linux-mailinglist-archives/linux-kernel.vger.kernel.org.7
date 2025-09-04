Return-Path: <linux-kernel+bounces-800874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 808A1B43D35
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A53E188AF7E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDE8302CC8;
	Thu,  4 Sep 2025 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="giQSzoqA"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CA4302779
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992541; cv=none; b=hQkJCsi4whlY2F47shPg7iQDjQrCG85Gq+TQF3+aMZCxUGIXdO3DTmQgHCkqV4RSLgmDwZKUkW43vb9QiCu+w7ibUQLWstSQrvemUigsHrGU20egpEFK1IcVSdmIAgRDAytCrRqZGFQuYcfgFlhrGSscWjEW8RhXAZw5CJZr4Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992541; c=relaxed/simple;
	bh=wqa7Ca/07c/im0pW7NjeH3wQc1LgXZaFgUeldip/esM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=npbP/kY0YiXVbagBN20FF9GQZhNsFtwTI/j8ESVVDZmLAu9UWRjZhLhpQRBjauUILAY+Du3mlqt2KrLQmOnZ8+IzHHavW5VvC85XyS4DjCYWYn8rKLgiZSUGD5C2YFXpx6ypq6SNKasrp5LberDumtbxDiUKq/UWsHBveyou4/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=giQSzoqA; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b9c35bc0aso9927105e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 06:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756992538; x=1757597338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwjkP+OkdyXJDv66oQ0CyedXSSfDjbG63ToGTcAWABQ=;
        b=giQSzoqAO2QYW7G900Zd98DCdMmpI4p1e2u1BztSTvzN3wIzrnuq0gfhmWwIDNQFOl
         QrCbEN/oYvDWn5uW0tGXNoYA1ZQ/0ziQoKeCyflqhPic3b+mT4euKRkolkYCexIxg+xX
         GRlCUz5eEwiUyKBifI8TSHvH2I/e6bJWLlCwyk7rrihglcCWCqM0k+WPstmSuiLkLAr3
         BISp2jWTCCaQnSBUJmUH8Et1oROjQ30BzzTPQDNrPcqiLmLDiHSraMJaZVFQ8vwMYQNe
         esMpJ6Mph4Dkw8CmTJjea8A6bjc7SNyfuRnJNYSnXnXUOfqT1UidltYZbDkhfBIiOfk4
         KbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756992538; x=1757597338;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwjkP+OkdyXJDv66oQ0CyedXSSfDjbG63ToGTcAWABQ=;
        b=qgghgb+YOIDLUo4ccdslEIjlLn+bZborMwl0HhrVXJY02WsIJ18iBqSUOqByGeJMGH
         g8EVGAYn9dKuuDczaUe2/qVU+ryfbADDzKUiRWzZxXZ/q6Re46xHSikI8zzWM82iNjXC
         rKjOENmiZ0i1iFpd2ImB1GtELsd5ZMdlQRMyqrK2e3RMV8itmR+0bfNCge2+ghTtjbWp
         bG3R97UrwSXCP9EO2uxUzQpSmWhCo/kmFlTiPPiJYA+PAmmgaedSOuHia5CgTTSKA1F1
         zo9WoRFxje8ZV5TQDCp3t8BaH9nIR2ql+tdgojASLFczqtDl5GngwxpUydYLI6d0s4nt
         XLXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsLaKfjJjBO4goAzZMzAuskSzBvtnlsK4QdxorXYGnFnv3SdTyptIQ9QSaqO3rLJSP7y/WQSY5CH40UG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRZrogr4ZKTMNJPwa1krCf2eOnhbOyjQEhGRglqfIws0dGX6se
	bHRgDPoiacAkJQYj9Itno+hnUrOgz5Tulh1WCsEa4TNWSek9zrSWWiQGQzt6krhyXMo=
X-Gm-Gg: ASbGncsh2jOwOovg90cilCeNZ8+DK4IRbA9LAfD6w7jv0qYAWXmrEaApSPVpohfs322
	Fvvx4JwEFlmSn8RS9kSNNE7LFe9GQg0v0S6dThGnaMrRO55J1VPpjfno8nnruDvHDy4uALKXGzq
	VyXb4DAAhUxN++IS9RvvUfsOtruuoQhmL+dNRJojReC0cLhjrjT8JOsf5WH1KUfzZsHyKz7if3o
	LehPVyAwdHvB0buJOFQFRbe0XroLUJTsoKWxkF+5NYZduAcYNvTCUVPRdy4Ueo9eB+1ZSG6JjzL
	Zjhujd6UkuNnDcCNixEuqQgpGsv36RQNbDn7PgMV4VVBu5qyzUVUK50pmeAD96emKVl94sVSFtF
	8mI8dJWIzjDVpnImmmTKrIFuuSVMHhKAL2+O0M3Imf5RGNfZj98lQCg==
X-Google-Smtp-Source: AGHT+IFc2iqk3tYMkm4EFxxL9R4GOj3DzOJyDOMOzUxuB34nLUq08b5Npz5Qy7crtT2kbpIf1kyDew==
X-Received: by 2002:a05:600c:3b21:b0:45c:b6b1:29a7 with SMTP id 5b1f17b1804b1-45cb6b12b8fmr62352635e9.16.1756992538058;
        Thu, 04 Sep 2025 06:28:58 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd0869b33sm34579425e9.9.2025.09.04.06.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:28:57 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Carlo Caione <ccaione@baylibre.com>, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250725074019.8765-1-johan@kernel.org>
References: <20250725074019.8765-1-johan@kernel.org>
Subject: Re: [PATCH] firmware: meson_sm: fix device leak at probe
Message-Id: <175699253745.3375485.7091705423903700055.b4-ty@linaro.org>
Date: Thu, 04 Sep 2025 15:28:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Fri, 25 Jul 2025 09:40:19 +0200, Johan Hovold wrote:
> Make sure to drop the reference to the secure monitor device taken by
> of_find_device_by_node() when looking up its driver data on behalf of
> other drivers (e.g. during probe).
> 
> Note that holding a reference to the platform device does not prevent
> its driver data from going away so there is no point in keeping the
> reference after the helper returns.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.18/drivers)

[1/1] firmware: meson_sm: fix device leak at probe
      https://git.kernel.org/amlogic/c/8ece3173f87df03935906d0c612c2aeda9db92ca

These changes has been applied on the intermediate git tree [1].

The v6.18/drivers branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil


