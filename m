Return-Path: <linux-kernel+bounces-864307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8ABBFA7BE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EB924EBD89
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022D92F49FF;
	Wed, 22 Oct 2025 07:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KL+7GcS4"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9439578F54
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761117221; cv=none; b=APROUJFFM6Xmzwdc/ibFbIgs95EDrxv5/5JHUjNm7hNw04Prf8O1vdO21k0yoTPiZdTBVHnXMGrJTxLXqbfai+RVUD3YRR+0VF9gN7vvoqpUK2NJI23iJeIbpR5if9O7uPxgPveOZWm6vPUVrd2xYGWQdezmaGL6URrcZussRC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761117221; c=relaxed/simple;
	bh=jYhprya5gTIQ4jQGJUepDF/AMXOU6Zkc0p9TOFZJGFU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s1FIwS0L+rH/4GfU2Rj0PWWw1Xbox3s5UAPWe95y96RoRXV7JkW7lEL0M3ITQQcPQnNuSGz4yLC+3xS64H1Wa+brRqfGuD9Nuu93tktKui9U8wnPf23xznoE2bvkuw0QrbAjBdusEOgSeyw2SU1WlsWL5ELNV9rxt7X/C1kWF8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KL+7GcS4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47118259fd8so40184595e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761117218; x=1761722018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqMreim9nAYer1KCbouUlT+cwbSr2tN/sZopAV8oBn4=;
        b=KL+7GcS4gAwY7m8ih/LytPhGifcvnvGsf0l2Lwf/xd+5uGSlLss4rZ5j5A61lxUMl+
         sAu/yXDvxSZXNHbma/2ze5YHr+Ekhi42LEOnnoa3k9SMZ0BGmn9NNKsXCB0g/inu6vUw
         S/H8JSYKgrppW+i7I2X5UsWLdGTpVG6c5H9WutHuQ0nAaYPvc0vdyyZXNlnpKZrY+nXY
         E1KfbcXue/EL0wVlpU30Z8eDOMhAy+nORPnZlLEoOImlxqbE9s5kyr2sWZ5/8ujCdtzE
         24lvZeWfb2XLSJSiu+Qi0/20ifTaq+IE4ZmuaJbeZt1t5mPtopS84wBxPiEc6QkB/BC9
         fqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761117218; x=1761722018;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqMreim9nAYer1KCbouUlT+cwbSr2tN/sZopAV8oBn4=;
        b=mT6roST7wW3yoIdOvr4Wa7IlfCapleodBotbbL9db95k1ZDN8NlCXLmrj+N26RmJEw
         1dxmMnJ50PHMMQEmbiV8sDaA0VQBNxrCxlf0TKZs8mCI/WKYYfBRw9vSFonuwqJMMrcF
         X0qauXhE1a9IjdckEE20vu8lch2n21FNRXeRMxQ8B4MknMl5mE+k+UkMNkTSK0Yvvd75
         cvubORthr4RW6m9zj3B2jJRMyxiPwQzsJO9cOIhRhZnwToHRzFpoMJUNYFHtloZn2O3l
         nlvw0pZG9flnC4pKjSGy8KbCLlqneAuu6d4f/eptDEDXZTrOZSxBoNNVnW1KCn+PZ4/3
         MjiA==
X-Forwarded-Encrypted: i=1; AJvYcCUVqDvvRREx23ay/oltWQynax+TOG9agDyYvrVCzWTPKrNIMFSoKYk0RFs0e0jLqs8+/u9BHXKWfuQrqss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQrWsb++yBBaM/OJ27XgeMaW6E+uJ3OJ1fWZVK5nm4vqTYyvLC
	+6npc6+mgwtZHZ/8G/cDaiHKCLUdTktLeFM5RJhvV5pqsu+sXagywvvzADd1ToMSwTk=
X-Gm-Gg: ASbGnctLfC1qTGkcLn4YL9ozEy/b8ailISgkDm7QFesrNa8Cl9sJI9UgzBS4VVrgWoL
	yQfFsZUJa8YfwdZc3wuvy625jot26CkGUZxxlZPfaO43Wd2vw9U14KGRfUwLuQhIYQZYAb5kpqZ
	lA8xJfVcIJbEFQ6tVlFMoUaUVSPYrcCybKVX4PXdA4Zx6/cC+JMC2TQl9WmKQdXSrpS9iqd/w14
	k/59S871YWiQJ6xRdcsDWQ3R/2N3qNXZnLWum3bhbWK4AcMib10GR7D6DMZiJsZWHnRLAZdZLrl
	BdsnOFmHyV7/ZN2QpkCHSyKeLYUf+ZfFxidoA07YHKEfVivy+sFL/tHsdu5McHnKFt2+/uEerk/
	+C8wxBfVJPAg2R55Tsq4dwwmZ8s0ZSd6he1y/Pfe9qEhiTtD8LKYV+kZPCtIITO309MNEXBLRh3
	aQaw1FUWxclf7P/TDOlqTc
X-Google-Smtp-Source: AGHT+IFrToHcy6QNjmKjXvKbtPCmRCoAalFEfH2Sz994Kb8x9DVcmCsK+N+zANuRJUkEATjH9AeXLw==
X-Received: by 2002:a05:600c:670a:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-471179017f3mr128014945e9.21.1761117217823;
        Wed, 22 Oct 2025 00:13:37 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427c3casm29428155e9.4.2025.10.22.00.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 00:13:37 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251022-a5-pinctrl-node-v4-1-a71911852c4b@amlogic.com>
References: <20251022-a5-pinctrl-node-v4-1-a71911852c4b@amlogic.com>
Subject: Re: [PATCH v4] dts: arm64: amlogic: add a5 pinctrl node
Message-Id: <176111721718.2414958.3337470167774710768.b4-ty@linaro.org>
Date: Wed, 22 Oct 2025 09:13:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

Hi,

On Wed, 22 Oct 2025 13:04:48 +0800, Xianwei Zhao wrote:
> Add pinctrl device to support Amlogic A5.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.19/arm64-dt)

[1/1] dts: arm64: amlogic: add a5 pinctrl node
      https://git.kernel.org/amlogic/c/a8b41683186d1465c06aabfee6e66ae0bb29f5fe

These changes has been applied on the intermediate git tree [1].

The v6.19/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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


