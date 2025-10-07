Return-Path: <linux-kernel+bounces-844737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF96BC2A1B
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 22:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDCE3C679C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 20:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806DF204F93;
	Tue,  7 Oct 2025 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xd/J7BL1"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74855221F1F
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 20:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759868519; cv=none; b=lFqWoqjeT2kCYp/gPGsC27G60iaZ58zLtq2uQUQDiOY7KwhS52x9UljZSlGltkmLAG4j7sZKKAOxChILTzpgKW07dk703dm2okTfCdK3mC/75MWh0Ng9Z6KULEnaJIdK6iP2TwhT+eMZd/7oH/5iqkzgRUKNSIXAvHM5lEFEFB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759868519; c=relaxed/simple;
	bh=rsR75QuYzDtr3bjoJhD52nZ9O3aIRwzpredTmac7Uto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nERR3Bau3bLGVvpklxRbMhW/kskI8I4pHQHN0oxBtIipotJs2pETz0IUyPEWE4OeqJ35TOpQaNH7XnEFp3qBrU5sIMk/FIUuM4EYSjQcIbh1M9yvH6lkBwskQtBGBzp62+s2/eUUg5N7Rb5uJFIptnSbE6xlnWH33s0IN91DhWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xd/J7BL1; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-35ba7c71bfdso3538599fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 13:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759868517; x=1760473317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsR75QuYzDtr3bjoJhD52nZ9O3aIRwzpredTmac7Uto=;
        b=xd/J7BL1zgqzxINf2VC4SZwEbpMBPxNxgE9Rq6eAfDnS7VBGu9qiqahJgZ7ZIOrtFj
         ZcR2bCiwpMuWiE5M9w5PQq/IR9fv/Zsa62XmbWpRS7O96M3O/SH9j8gNliVJwEK/BkP2
         xXjLl8I3WGhYYmIUlen+mWzksspr15ZzbS/ajkEs7xhgIDFJT0uT3U4Jo+kqEBTedOjW
         oveNJaNVIPVNtKBaktT+v66H1b1xmS8Sg5BXNyRX545HeVOdtN56eVsJOlf64CCqmbn5
         U5GFxcHqbRSBBLQ20LjnoCrkzCVZEzMojdb4pzPz5XF6gtPl80XyKNiq1uac3xAarkZz
         /fAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759868517; x=1760473317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsR75QuYzDtr3bjoJhD52nZ9O3aIRwzpredTmac7Uto=;
        b=R0Jv1M0PJr8JtiDiKV50CxyIt5oxibE44jipiUkH/UxBAT/FHZgzFw+nmRBP5wKQVl
         O8pBwdXTT7ommA+rcpUwUg8+s20vmjvD0n/dkCRV6/oCr04/7tg/1bV6Xd32B7Z4+kmm
         SZ1+IBTZe/+RUcs4k8g8DfFii/2Ckd+SV1oV144x+jCqCHcdL8J1GqremwOEdZa+3oQG
         lCrW+h/IVZrlbptrta8k6Zvzsz/ra5AeumRB+f1Ca/Tzb/mJzQV6mur+dRfvJ4pc46Du
         sB7IhW5fvdp9nlRCb7oh25AnRpIhLj25s5SvM8TJoL6zWrDvI7yV5NXNt/KzO3iysSMj
         eDXA==
X-Forwarded-Encrypted: i=1; AJvYcCVFQdpAuecKqprR/5MQt4XXcFSOkG1rTiAJPOdxkYPTE4pC6kess54eudEirdWEuNLeNbECvuEVKqPWvTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv4MRvwtT+4SIumNByWo0cFcTosq1LLekLGuo/PppqpkquDHje
	EWyZr7KaUenGYwg44/dBjFXZjKTqoSzftjsau03sqoI1thfwIz6DPWUPHMaakj3qZPP76PM4hsT
	jVdIYqEbpZBufRlpahLewKvDOw1pXePSW49xaLDxRVw==
X-Gm-Gg: ASbGncsggKBSRDb3eSRYFvF3xFA/1gqwrg14aTo8F9ImSh2uN7rhEqez0sD5WKnXSrn
	uNPyGcei6rmYY7/s7z6HKmiD9yHnPIN82qqEbhbg0FdphOlRL2gr/1jO5icPXGU7Ajy7q43d8Go
	a9OTjVEmJueYyBIWe1EFroIVhlKeEgmmuCYVZYkwtUobeV/FiN/2edZog4QJbqhLxcy85EreCik
	6nwpTfp4pdUrinQxNkzfaVZeawKpGc29aD8lQ==
X-Google-Smtp-Source: AGHT+IFvtcyKjlupXR4jzZXFoUiymzWiqOCATc5gJjSvgUyoKVMUYlajN3Vs3NoiPv+/rIeXC9ZrtBcQe+GkyueiNcc=
X-Received: by 2002:a05:6870:d88f:b0:35a:cf5e:fc5a with SMTP id
 586e51a60fabf-3c0f5c131e5mr532073fac.3.1759868517577; Tue, 07 Oct 2025
 13:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-power-domains-dt-bindings-phy-samsung-ufs-phy-v1-1-d9030d14af59@linaro.org>
In-Reply-To: <20251007-power-domains-dt-bindings-phy-samsung-ufs-phy-v1-1-d9030d14af59@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 7 Oct 2025 21:21:46 +0100
X-Gm-Features: AS18NWDCwphF6RRiccVd74rxfHhTkLJzBEXIn28O6vitl2Y4s82jYqPTESZUVEI
Message-ID: <CADrjBPpCLcaeLn+SB4K0gPzQtT97SDw9xsszw6rtPO2Ue5kYNQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: phy: samsung,ufs-phy: add power-domains
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Oct 2025 at 17:01, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> The UFS phy can be part of a power domain, so we need to allow the
> relevant property 'power-domains'.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

