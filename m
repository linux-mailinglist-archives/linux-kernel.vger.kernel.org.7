Return-Path: <linux-kernel+bounces-858095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75508BE8DAA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB5519C6441
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4FE36CDE9;
	Fri, 17 Oct 2025 13:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TJJTlH+A"
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFFC3570A5
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707872; cv=none; b=gN+/Jpm8LR6Nb6+wTUR25FvKdOplnhFrCALDp3W4xsM1ih1JBult0F79EhcS+9YSMH8oLzIDMdUSj8VpL0LjnBWNxgNhjlZjolVHWanYgSifnwMhLHH+3zGMkewIuhnwF9j0EMWB9L0RnB7XYwR2ul3kxq1tSRm3FIy6EpKosCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707872; c=relaxed/simple;
	bh=i+O3goYjT4QQXxLHScTtYR8tB+lqI6cv3xXIRKCisAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2PsGsLssAb4LWen7ct1b/S86OJLij/ArPoUXL1G/7dz9C3cZi/YtX8qERgy1ZKD6pMEEZkWlLKKv7G+nHxZeWUbM/zETDcktlY2AsInohZFpJH9s0K49GQOX0UlMKzkcUI63xUMfHBmwDFswcIljPP2z66BOnBCvlN8Qdn5dXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TJJTlH+A; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63e1c0fd7ddso617542d50.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760707870; x=1761312670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DUCXQ0EvV9ktxmOlNW52FjkhtUMF4mrPMo81WKGkY7k=;
        b=TJJTlH+AdWbVPr4lWHccUlLtKQCL3SxG2ftDDibxk6+eXLd1N7cnCuLl8Kx+f2K0dB
         dT+gLRQLmsQVVSy/FZKcbqz695iwUYEt3a6HhE1dBhPEIieivCgMMxvlwdtKh+f+62Op
         lImGEchQ3yjfl11cG1oTk45WIZI4DtLkWuOWhw8M1snVo6RweJ327YgzPRXlgVOJNMLr
         SzqZkJtNr+vPctEku2JQ4Xof0cM7f7xL+ujd5OQHPdQ5+tNwH8HelbtNwwksXRcPguQm
         Iq57lKxZyB9tWpilqu29YwFnKl4uBD31YkyM3jo3g5F96p+szu7MettjmWh2GzzVBla8
         h9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760707870; x=1761312670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DUCXQ0EvV9ktxmOlNW52FjkhtUMF4mrPMo81WKGkY7k=;
        b=Dr9CzD0NxaVxudXaFw4ajf4fxOCHwInqHz9YmeTJ+rTj2n8gVnACswpt7EkhN208Cd
         Hv2D9fSNOs0PJVp10O6hA6bX3OlCF8zA6QsNXTFXrLYEMpdXqUAccZNBoLsIxCWx4Rum
         V2/VtspTerUZmAAYkVHuSmZopKV1Q9rUzBzVK/mbkob8t/DO/Q5PqUGcwRDyogvs2xhQ
         iYNwLa5N0iyfNtieYJ4myW7mrW2Cn1YKcB65pwLg/+5R0bca44enfug5y3SvL9w5XtfE
         w9n1n3b/6g6qcHX64l9t0CYop3ci47dMGYraZ/xllY36N0C5Q2I59jAt9vQtitu11fMj
         y5CQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0q6/xrQ8z8zphF0jVI6ee1aMZ2i1llNI/Oyl7gh/AdbHqULQncV5XE4w1z3eHzI4mnvgWk3ct4UDqAIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy04pn1QuXWB2M9otubhUE89sLVWcP8SSkOT6PqRG8pUawBlbD4
	Wo5RIaQWOMI/+LBGxFvW8tAToAe8re2Sg6xwGAejrrbBJHNq9f811wnNdutIyDTmR7JGpZS34ng
	A6Dz8uzO57iRkK60ZzH2tYYAuRgoOQYPDpfHTQAbf0g==
X-Gm-Gg: ASbGncucfvtCHaLq30PLUDFEo2z+W5b3hKs7BYKQ8DRQtLLh7jSf0APiR2cmrNZeOZX
	iE2f8MQDB0PgB672HZ0aEPAtAKFC0vgImlrWfutxPetst+FqiG3gGi4/AQ3deyJxN6VnFdIcvxs
	vvt9LwDtw7g4IcMIl9bbHV+UQtdx2/X/236nHgNusFlpq9pYM+5kiMhF0ftQBzZ0lvmnF4ugofN
	uFpkL8AQS2cF8mvmnaAkqcvZxc+wZYSO4jhxOTPSgWSPkFfFQtWMEVrEuJk6JZ8qAAWQI6I
X-Google-Smtp-Source: AGHT+IE99aLeU1qJuGUKKD3EwC+82B0WlUi+IrZYAAKOJ3BjaAC6xXwG/vSFF6c7L0L5r1xHD6BMxG1tEIJhEP9Q9Zs=
X-Received: by 2002:a05:690e:4009:b0:63e:17d8:d985 with SMTP id
 956f58d0204a3-63e17d8db6emr2723484d50.53.1760707869805; Fri, 17 Oct 2025
 06:31:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007140434.606051-1-kamal.dasu@broadcom.com>
In-Reply-To: <20251007140434.606051-1-kamal.dasu@broadcom.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 17 Oct 2025 15:30:34 +0200
X-Gm-Features: AS18NWCxOo1IPoxvNmAyvX3kK0QzpALZz5b5Ua2IC_5KvIDu-uhmuTnAMYhlcsU
Message-ID: <CAPDyKFrsjnSYBTpPJ1qWXVHTZSw8EuQh6b_CcNAKuKHHMwy2MQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] sdhci-brcmstb SD host controller SoC specific enhancements
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: andersson@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, florian.fainelli@broadcom.com, adrian.hunter@intel.com, 
	bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 16:04, Kamal Dasu <kamal.dasu@broadcom.com> wrote:
>
> sdhci-brcmstb HS200 configuration for BCM72116 and PM register save restore
> changes applicable to various SoCs.
>
> v2 changes:
>  - Separate commit for SDIO_CFG register defines that moved
>  - Implemented cosmetic changes proposed for initial change for :
>      "mmc: sdhci-brcmstb: clear CFG_OP_DLY when using HS200"
>  - Moved BCM74371 support in a separate commit
>  - Implemented review comments and reorganized code for :
>      "mmc: sdhci-brcmstb: save and restore registers during PM"
>  - Added Reviewed-by and Acked-by tags wherever applicable
>
> Kamal Dasu (5):
>   dt-bindings: mmc: Add support for BCM72116 and BCM74371 SD host
>     controller
>   mmc: sdhci-brcmstb: move SDIO_CFG_CQ_CAPABILITY define
>   mmc: sdhci-brcmstb: clear CFG_OP_DLY when using HS200
>   mmc: sdhci-brcmstb: Add BCM74371 support
>   mmc: sdhci-brcmstb: save and restore registers during PM
>
>  .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |   2 +
>  drivers/mmc/host/sdhci-brcmstb.c              | 154 +++++++++++++++++-
>  2 files changed, 147 insertions(+), 9 deletions(-)
>

The series applied for next, thanks!

Kind regards
Uffe

