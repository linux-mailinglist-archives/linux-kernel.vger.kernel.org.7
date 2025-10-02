Return-Path: <linux-kernel+bounces-840005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55674BB3420
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 10:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A1F47A7FE6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 08:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A6C2F25F4;
	Thu,  2 Oct 2025 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KOI05EOj"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1B32E229A
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 08:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759394489; cv=none; b=C/oMLZWv8di8+TiIv7HYtEUxjKy5ccOaJfuH6Q16uoh5zS8k9L7bHUyIaKffnn1hIY2thA1+OEse3UEr+kuiZrbfjYziWxB41a6mONU5s25ZLRgGhxT/U5gDNdrhS9KkoTvQ2V0qSEX0yjT0EEqQRmpcySTIQy/JlSTBcbjirSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759394489; c=relaxed/simple;
	bh=KXEH8lY/tuXNDSNR525jGqgLwK5Fk3nK4GuTClcHc/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1skg1pFErHgPlOFzw3+QPRgmZ36/jP1uoHocd/JZt0zRqQqSJEJkK5B77JI5pkJSZg62oDSYgeSJoPLPCjSWudYv5CBsu9XHwzdvg/gkv3RHCp4cKe6W0qjyNoWO7HJrnNrqk6Bdw8CddHvnVCEGTVjcTUkSC+ApoQbfTqoZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KOI05EOj; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-330d1565844so554723fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 01:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759394486; x=1759999286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRs2HgZQCtBeGXI9qj8l0L5wA46oSCjHp6c77COo6HE=;
        b=KOI05EOjoFGTwea9jR0vkw2CKU6laGmJha0OIFCzekBZdrSf9PIuVLjUGAfAhWcWRy
         KP73cLlNPxMhOE6vJSd7tEhZ/0GoqV1/I4KlZYVo1OcWJIh3XycMjMjW29in1nB2TrYn
         y9Pp1f/vgAMq8BGhmlxwtdRUwGcS9Ai1isuT5PqVjsJpOHn2sZBf4unp+KDTlfx714CB
         vhvC0E/Brst/GJ/R8oKU1A9cLnieZ5EKf7x8gDUML9QI+1vffjGl1Y+gdfTuiWpQhwYR
         Gd/rKYv0GpuCdaXdYyJL9ybmRQjnuyCJraIOSNteHuA4O8EjwaRC9V2enlKecmGf/7Tw
         OMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759394486; x=1759999286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRs2HgZQCtBeGXI9qj8l0L5wA46oSCjHp6c77COo6HE=;
        b=lbMYZnZIcnZ+vKMIkcDWS/mP6jYjxJ73MMfBIT2x6EV5maoL4ariCzKaMD02FgOzCH
         1Sz0vQNsei3CJF6uKOuh7SyvC0I8cibRlBTHo4Q0BfWnxU4wtp7+9qdIZWG4ydzMkYhJ
         FxCswwUEE1AeYXSqwe896Qaq0jkEjaudKpBZdnqgXrE1WTXLRXwKIeRpO5rAXvtscv2U
         6wTspX8ipcSXtOlUekJVDn8VuBJxLG+nY/IsP8dbs+pO/rFHee7q+itlrQBBJ9OAh1Os
         fsV0tJEvC+tyzFpwAKgLWbp5XIquH/lZQuuGKhqTMYnlAuYZS1AVt751LU+RZ3KFIdnt
         bnlw==
X-Forwarded-Encrypted: i=1; AJvYcCV/5AChKRLYgT6B47/+Iv0BkXEMybJREY35/zti7H2rg8soTKIxprQXDJTlNs83AxZ92KXZZ8tKIF4bKRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYdTzHEXb2vojKJy8pJldTNfNv4ExImk5lzcfQibaKqu3vbrCu
	Zi2V3vRZaZD2K9LphvB8U+Mh9prILwXjV0jIyIRjO7GS84RvTd7HCzoRQVNCz5R/Zmx4pG2Ujtl
	+1gIyYZinXAFb4OaHYR1mWqQ39XgycZXlmfxVETSRbw==
X-Gm-Gg: ASbGncsZfsPLpBO16RECZddQUEftyex7IAmy7A8pLFPID/Af+s1VTJTYagsu8Dhrh4A
	ffjqgGCCBCj4eyUhARw5stkF+2hWNexazFW1mON9zt50u75NqHhY45oFhiTtLyCc9PeGGrFT07I
	uu7C/eFCnvTTvUCQtTsybKTrugeful6zTt3mWgq4tFmM4uBnf8CwOkSIuRUD8mQ8vgNl+2VnWPR
	q9AK9K+0cyeLA9wXSI7J7UoGAn+LU3yihS9
X-Google-Smtp-Source: AGHT+IFdxe19aSB3FNHWco6xM2pvw1ZN8obwBln7idZ5E/P9IK5Q/zYbBXb1d3G6WQQ45jHzBmBw7fP/yjYIvCTtv1I=
X-Received: by 2002:a05:6808:3092:b0:43f:7cd4:4fc4 with SMTP id
 5614622812f47-43fa402c2c6mr3295400b6e.5.1759394485922; Thu, 02 Oct 2025
 01:41:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0b14c3d51245f9eda2341504c05bd0f5b0828b7.1759243439.git.geert+renesas@glider.be>
 <a5907537-cecc-4564-bae5-981d3ad85d7c@oss.qualcomm.com>
In-Reply-To: <a5907537-cecc-4564-bae5-981d3ad85d7c@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 2 Oct 2025 10:41:14 +0200
X-Gm-Features: AS18NWD-0rE6kz3-A73Pl3SUY0al8gOtGel9P-SlAuJ2V3nZRT-_jgAcPjsmPd0
Message-ID: <CAHUa44FcCyqaWCbsdEMj=Jr9vcsxHh+nK1qOqpbtJsx89C7tqQ@mail.gmail.com>
Subject: Re: [PATCH] tee: QCOMTEE should depend on ARCH_QCOM
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, 
	linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 10:23=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 9/30/25 4:44 PM, Geert Uytterhoeven wrote:
> > The Qualcomm Trusted Execution Environment (QTEE) is only available on
> > Qualcomm SoCs.  Hence add a dependency on ARCH_QCOM, to prevent asking
> > the user about this driver when configuring a kernel without Qualcomm
> > platform support.
> >
> > Fixes: d6e290837e50f73f ("tee: add Qualcomm TEE driver")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Applied.

Thanks,
Jens

