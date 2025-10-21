Return-Path: <linux-kernel+bounces-862889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3366BBF6742
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB2119A3A1F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3476032ED42;
	Tue, 21 Oct 2025 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KRU54xX1"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20801DC988
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049789; cv=none; b=Y/cGcCG3h66qNnu/0bgIwlOnk3l4ccn1stDSW5ucLU4g+ybrrJLpA9oVOdPJPhjDbhSSAH8B3xV4xiB8z8jSEMkNN6PB9kND5HDxK1oz8WJczGgXUyIX3ad1psrhF1SJszCg6AMPYwfi+YhPqUam4merAmKvvIhcef6KlUcjuZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049789; c=relaxed/simple;
	bh=tI/abLRM6RRTkjpi7bp0htXWDFC6rN0dzDuIsEtxgMA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pnTPY6R2IoVOC7Ib6u0c2RTJ5ijTy2HN++krfKu5vvq1aVDhIHgup+4I2sMvQcdyPZlqUyrJUqnRBMvB72AFkcqqkXgF6I6cx9SomGNkDJu8JiJroBcO1OXnkhGy8PPmajLtaEwHxzb38Z9UKaQB4dEWYquHvTG4bF09nqfxzQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KRU54xX1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so1069832f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761049786; x=1761654586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfSnV9t1F/SDBYI2zrfencQ/tnUy59bzGcgByOeP5HQ=;
        b=KRU54xX1+UWf6Ux8S3urtZpTMteYLj8lWdCjWRc9baYKCEqI1gmvxQbIz758dKPqWW
         cJjtBI4CDqDThLG+SmGxSf1oP562+GFYfFJPwQQqcuSIycJgQUM1JJ4XSjRSASRuAm9z
         jfSgQgV5ajg8Lt31icVquTVxdcNtUG19xTgXHHbjwfVabmaN1xgSZQoV2jhoAokvF630
         Cd440xMbyVcDammePjBF0DRN2C8ceVn4oeZoCyTMUf2X1BYxUv5LcfauS+cw6giJb/BR
         DsNL/y0O+CRqfPZzpVXU4mIrSpCSOzdqSqZHMUOyoTqnBDtGTxs7Rwam3BquXehT6tJ/
         GoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761049786; x=1761654586;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfSnV9t1F/SDBYI2zrfencQ/tnUy59bzGcgByOeP5HQ=;
        b=ZguoUclIQOHHmJ3AxUUTwJ0q6dZTmA2lgloZEFkcXRUKyY8gBnRKKuPBuNby9as6TU
         dZ8hl4dHQCKgIYZXhim5V2vtT4kwqM9Pu726HPVeSuN5wBBQtJJIBAzQq2uZnEIyTSDE
         QFKAnWvW/JZIq2p03i/wTbNqZT81e4kJqWqlC69MpOOg4l9S6YcaTSu3oUGjNknPtNAL
         HLx8Em3da1SSLyGlu2QIM6/FBBvsUARydOKBzMuTjaC+JhLNvh0pglbbzWSoupfSRtSQ
         yerf1VYp1gZc9M+YU6HRT7Gc108DtIv2M9jaUO89WrvfO5pdQgptaPvzHJnj4NTA0gVJ
         IRjw==
X-Forwarded-Encrypted: i=1; AJvYcCUMfRJ2sZC3GSkSW4iEa78wUgPRChEjYF9t6FKc1NFB4Zq+ydIgbdfzNgsHsgh/zgzK9pAFcB70jVPNcyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPyHXjfvxci+lHmDqnZjDM3H+dPG6PxlUwgKUkA7rMH8PWEzW2
	ls7z7rQyBxQVSP8pqH+YfoTEMgCWk/jbMNSMoE0pbm3pWwqmGEPrYVFvuaNurWLuANA=
X-Gm-Gg: ASbGncsYz0sO8Me9aJTdWGjD3mV4hItiXmR72JusXb3o+Qr/Bl342Dz+YC3BNw2w7ms
	7WzThGHC2Ge82/po9bJKxBWqLAmuvgzoDAap4b02AoBtvtXVOhjc4WilFaKXLom0Ct6nHmsDqyb
	7ZHsupS6oII40NZDkwz4cw4bUD2gydBpvM7srbOFt5rK8nLlNerck/VqfKyYtPvRwf3OsaSHjOB
	qCKo/sGq5KNxrEMVnCmh9orYIAFGWmTPLGzVGnBZ7FQVUnKixej4KKquOtII1yJ2kDMaYONjSlI
	+TZj7k1J07SVy0I5U4e7ZLdljDp3biN+c7UWo+pMM/2ENZ7TZkvqLWb1C2sjQIxBGexMDlETyLT
	F9RL9XddRHS0mkG7HLJz5udd/DssxeMTInRp1eDqIMJ18Z0IHKow+5Poc1i+LDtHrLmnjKcZzGj
	AmiFNK8GUGeQEZhFMPWXrEinKeJaliR7Q=
X-Google-Smtp-Source: AGHT+IEpSASoRALREWuHJtczt+cRiPjUi8QW3wo+6igdJHTvMSXLltYmWA/nv4zRiVtwUcuiVTG1NQ==
X-Received: by 2002:a05:6000:4382:b0:427:a6a:fd44 with SMTP id ffacd0b85a97d-4270a6b0aa2mr10341671f8f.61.1761049785881;
        Tue, 21 Oct 2025 05:29:45 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3c34sm20057043f8f.17.2025.10.21.05.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 05:29:45 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Keke Li <keke.li@amlogic.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250918-b4-c3isp-v1-1-5f48db6516c9@amlogic.com>
References: <20250918-b4-c3isp-v1-1-5f48db6516c9@amlogic.com>
Subject: Re: [PATCH RESEND] dts: arm64: amlogic: Add ISP related nodes for
 C3
Message-Id: <176104978523.3075289.16180550527361572624.b4-ty@linaro.org>
Date: Tue, 21 Oct 2025 14:29:45 +0200
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

On Thu, 18 Sep 2025 16:35:09 +0800, Keke Li wrote:
> Add the IMX290 sensor node description to the device tree file,
> which will be controlled via I2C bus with image data transmission
> through MIPI CSI-2 interface.
> 
> Add CSI-2, adapter and ISP nodes for C3 family.
> 
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.19/arm64-dt)

[1/1] dts: arm64: amlogic: Add ISP related nodes for C3
      https://git.kernel.org/amlogic/c/63aa70a1f84f5dfabbac28d60e12949705876648

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


