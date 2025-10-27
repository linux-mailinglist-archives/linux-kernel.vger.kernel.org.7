Return-Path: <linux-kernel+bounces-872626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749A9C119C7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F46819C7401
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3769C31BCBC;
	Mon, 27 Oct 2025 22:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AY1Ok+NS"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45DB2DEA6E
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761602705; cv=none; b=es566yPLne9e/REea/txiRRh/hH+iv4B4SsuPs5rxaYtcXuMpLqA8l10Yj6Kc6CdD1bLhVMmUXicCyPxnWCXA9ReESseoR6xD0DIKlh4ROouzPLvMMINrwT/ZNqr6X1suWjEpEQFwjc/H5cyhTf5VJNdovUTMGGZLmO5tT3uZt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761602705; c=relaxed/simple;
	bh=881iDkPEZh85ObsSmrMAZ48Htve0Wj9g+gfovyJ15uM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYIsM5Lv0BLv2uXHy8lDOxbRzenusKMCfU4MeGpsCRxljQDQaa3OlxHpGEbOHekXLiqkdR7rO89veqLP1osz5aPO6MTcfdkMdjQ0nFAZwKE6aMwkWEuBuNJcZOmkG6TvGfQCkc9OCoeZjpS1VBnn2bkJdVi+HHqyfHoQEjxrVoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AY1Ok+NS; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-592fdbeb7b2so5081561e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761602701; x=1762207501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=881iDkPEZh85ObsSmrMAZ48Htve0Wj9g+gfovyJ15uM=;
        b=AY1Ok+NSj05rf5B6Qk9YA4ZHIYVjoSO1m2vXDJeJK5UNKe9mRGKsXW5EnjQ0+JwY6L
         bInfp+u8gcsWJtvLp6SYv5te/smbG06Hrx7cLF85ElCL1bWXT+uTCn2Emih0ODIR7t5x
         HBLmm0G33Xx1mX8/lmv2UH6YLP6fZytuQTv/frdf3MnQz/QHmHrt64Q4OKtAeUiMcezu
         L15qNzUqKfgFWdeS37d+PdpwXF/5wVxbb4ohDQ3FbZjiZQrnXPF2TR+NQX126RWOO054
         7y+dcqJ0DhZBbZ+k2auEkaEG2j0cyzAOyMEnGX8Qpw21DUJCAz4NXickpHwIsoEl0lXr
         +NXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761602701; x=1762207501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=881iDkPEZh85ObsSmrMAZ48Htve0Wj9g+gfovyJ15uM=;
        b=UZhr2dmozpfT/Jp5hgaFiXAQr0q3V1yKA9YIMILjmB/OCby6Y2J1VJchUKAZUEtKEZ
         d1mlZxCaNDNUfH3INpy7LCEe+oGgzqi6XLbNYBK8P7d9Cs/bPbBrpxRsp1EGLYdHfoPb
         sy3ndLe6pCC412ypATSynlPZEVg1FglNk+f5ow6l5YqrSXZ3Cik7Ep24SxRpEhJMstfE
         FNiGnxBZwTtloA+aVXaCY5aejzDravUcNCZZpLs7EDEpluX+WpRF6IfPFa+Xi3GodtH6
         NnYNK+InEjRXzN9Mkud1VdwtdC8RU+FVNt3m62TGdinUp5PWsSqd/lwQwhY5cjQ/Hics
         CKjg==
X-Forwarded-Encrypted: i=1; AJvYcCW9lnELqzpuezx2XnepydXSZ9Ou0QmKgjgbAcPYSeghwzLg4SnGi4UCGtqTVLC8Xk+aLkp7ZZds7DCOZnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt3Aa7B0apitAbHynTdzHDa61kpyDqJTxRufBzfCvZpILhvCZW
	+rCe9dFRc6/BrWL71YLGYM8j9WkECqS+1syI963TkdniKM0BmYhPRJXFzUgqcBGOkYHQreMn4nk
	rDETYpg+JnVAosIjwPTZHk3bcdWB5Zni+FkO57Gy2mhsv27izHorK
X-Gm-Gg: ASbGncs1dgGa8PpTdQhrVly0FXBfmr7wHn0Kbhho3epITtEx1AmyksMmwD+3LwR/IVF
	qcjcBiY77zm5GUllo+y8NBeDnWuRZmNwda3kpSeDK5hxnbKd9IT1t1EbiYiuOSNBHVYLCr1f9lf
	rwSmHtM4en5STan0R43hBkyJfCXZ4L4sacQ/xwtLXKMJJ1y4XZj6rrrXuXi/65sNyvkXDWSw+pl
	RSztW9Zz9g0SwC/QrC9k6cFtYquOfDL8yr6+ZZ1/sna0s2ppUd9Yii+qeceBNn29jeCpVg=
X-Google-Smtp-Source: AGHT+IHoUF4RHiTK1ixTbcpPhI4tBBI8uNgdSo0LDy74WVyTiTCN+lBwjm/Roz3VFn6Yvs6CWMINeSQ/2LwI3eIrZ6o=
X-Received: by 2002:a2e:ac13:0:b0:378:d757:d307 with SMTP id
 38308e7fff4ca-379076bc3a7mr3168981fa.11.1761602701023; Mon, 27 Oct 2025
 15:05:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023132700.1199871-1-antonio.borneo@foss.st.com> <20251023132700.1199871-2-antonio.borneo@foss.st.com>
In-Reply-To: <20251023132700.1199871-2-antonio.borneo@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Oct 2025 23:04:49 +0100
X-Gm-Features: AWmQ_bkqvtHBv2ihzMqbHUb5leNu-ZCVXzL1Rr2PRCeRlwPcmd2dgcjDCOHd-pw
Message-ID: <CACRpkdYUt3mZX_KjFps_BSRQVrPcn70SrwEJGKRQUjHq3VXcDw@mail.gmail.com>
Subject: Re: [PATCH v4 01/12] pinctrl: pinconf-generic: Fix minor typos in comments
To: Antonio Borneo <antonio.borneo@foss.st.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, 
	Christophe Roullier <christophe.roullier@foss.st.com>, 
	Fabien Dessenne <fabien.dessenne@foss.st.com>, Valentin Caron <valentin.caron@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 3:27=E2=80=AFPM Antonio Borneo
<antonio.borneo@foss.st.com> wrote:

> s/specyfying/specifying/
> s/propertity/property/
>
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>

Patch applied!

Yours,
Linus Walleij

