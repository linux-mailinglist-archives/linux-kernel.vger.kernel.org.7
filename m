Return-Path: <linux-kernel+bounces-873415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 118CDC13E09
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026D33A6057
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CF819E82A;
	Tue, 28 Oct 2025 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BndvowXS"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B36D2DA76C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644337; cv=none; b=nydQapo0I/5Viat1nwQJsSes6zIARNFkOeH2XnVBVTkXS9bi+wfg+1d7l6/+cTkfl9ybdkwwYZvxhvcFOnJlfNKk5Zt1LsWQgmGbr/XwzKIDaEFk2aPM8YQPIt2D/MdgspMe46MJgfHjMuBW6Dlt+m4B4xaZifNjqJCHFaH+qCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644337; c=relaxed/simple;
	bh=9XT29P5nG6ybcTWqNLWy6LyojXTlR4aBnuox8K8qQ7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3QcGVvUFYsIWGcUtqU0+UnI4U5ggW8ZqKMw+EdXnzaqK93PFXUA1lwXQE+swkqzWFdAu4YSMwStxHSzCpCev5b7WpVdMJyG9U1yr91A8WMJcFjDWS66RTWQRPUxDxG6qK3jiXdFT2PIrquRnUjprtpWbVGLME4v5tyunHs4jIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BndvowXS; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-784966ad073so71555967b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761644334; x=1762249134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVeiwoRqAoE//vzYcx4vZTWn79lwOq5iCXrye7CBQN4=;
        b=BndvowXSbu3KzjeuIB0MEYIVBvNE6b8Zj4Vh1fgkB02AOG8Ms/fWPrPpNqzIvouwH6
         FESsvfOVT7mkSFypOjjIcs2Q/wI3feXYTBQxIz2hk97J5roJvMhtvnENUurBj1vp+jfJ
         TVR6lBXKHS9EvxVoTXz3j+66fOVX5uSWjKNXidpJJzOFoWL14r6j14DgnaEJ/rc+Mh+5
         wmyQHInB9nBy2QpRECGzHdOp8TXDMsCogCgowpLFmZuH6nQyk9PHSlcv5Kzn3mqsC+kJ
         ZTLvs64pn5bTAFs5f6kLb0Ae6xTIkhb3ZSI/OWH9LOo2zal6d+srcL8iuHJ3J0Kgf3LG
         NRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761644334; x=1762249134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVeiwoRqAoE//vzYcx4vZTWn79lwOq5iCXrye7CBQN4=;
        b=TUE1Q6pfFiQZ04wpzmk7FWyWu1NVe7hk9DWyz/EOL9cxCjRmsib8YXi2VVzDSfEN3P
         mV95CWzTuUzz2i2t0Avp4Z0shCDD3F2eud/UiFERa529KD5NTjZpz0Pppqb41E1iuVY5
         iyJjDK4kt/NJOhFfvWu9pUjra3thfwRtfXegxiKTCP9JGVxNa2d9DDT2tlpyFA8c+G+Y
         ls8NjsMsjhkR/2Uub2gMbwCBY2SYMSQMQCdx0orc7b2dazFoqN6rfTG+8AeyYOCVhrmU
         f4KVcznhTcRq0IMIEBgtgHlS4YiY4V9wEZUxq27Q1CyDbWA9cB0EgipdgFZ5GFDIcg26
         AJZw==
X-Forwarded-Encrypted: i=1; AJvYcCWiN8/YvPTKprjG1RTtDeGlnZhKhoXi1newjMhGpFj+LPjVVu9cbu8OiW9MJrGz9C6VvfQgrjFEHxyMiL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG0v5QtuGPPj1NRkrlO3yw+6+h1pgJRLfGkmYMnahNFUGpeNvW
	UAFeOs5JdJHkNVNed29XaRUmOFIlB6/KkLZgDOsWzvZ6CURHGgWMvcmBzRfZzoPg8zV6Wu83EpA
	qfN9V8zXFV1Viop5rSP0BFEqVcLVvV4gEOtdVMR9YEIX2/NCx68b/
X-Gm-Gg: ASbGnct4vD3i0vtW9EBoFGa89XQ6U/uCXCemHYID6MW9oKfZkq0lCghAE5jTEOw53dc
	u2G2rwbpGF5oyOkngc+rBKwn4jlINHprgYtZYyURcmQHFMo+PGze4L/pMNsJhGLp0n9Kh9waBus
	l7pUMjD93s9Pb/ZnOA433Bjnrz8rvFreYq8nU6P8SowcZqTED+p3Dyf82wlGQ7pYNINaezOPwYg
	u2bFkOSLBPH+GHrXTxv5RBOYMXC+pgx/6y6DktKSgSdoGzI5/v5bQo6/mfK4DrmGlQIKj4=
X-Google-Smtp-Source: AGHT+IFCKmnaPpXTAX3Mf+PwlXuMSXSX4zruOYSEiuVmo7Chb+u2cHajp0OhOA5+lkBXv4HGJcasVf0Bbiy3XKcmsAA=
X-Received: by 2002:a05:690c:ecd:b0:784:8644:27cf with SMTP id
 00721157ae682-7861838ebfemr27771687b3.55.1761644334550; Tue, 28 Oct 2025
 02:38:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028120224.1c7ff0eb@canb.auug.org.au>
In-Reply-To: <20251028120224.1c7ff0eb@canb.auug.org.au>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 28 Oct 2025 10:38:42 +0100
X-Gm-Features: AWmQ_bmF0Xk_seuQOVeZSwLTJtUIYb86ntNFB7ktW8B0ffUwuT0Of865jbW7_mw
Message-ID: <CACRpkdbvU1LKdEqHQwZT5uk8yWz_F5mcn7CvnYBrb0c06PibRg@mail.gmail.com>
Subject: Re: linux-next: duplicate patches in the pinctrl tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Rob Herring <robh@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 2:02=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:

> The following commits are also in the devicetree tree as different commit=
s
> (but the same patches):
>
>   9760089ca4b6 ("dt-bindings: arm: Convert Marvell AP80x System Controlle=
r to DT schema")
>   0385f89a0cbc ("dt-bindings: arm: Convert Marvell CP110 System Controlle=
r to DT schema")
>
> These are commits
>
>   3fa6e2a0ce21 ("dt-bindings: arm: Convert Marvell AP80x System Controlle=
r to DT schema")
>   5024ac81c4cd ("dt-bindings: arm: Convert Marvell CP110 System Controlle=
r to DT schema")
>
> in the devicetree tree.

Aha OK I didn't know they were already picked there, or I forgot it.
(Rob may have told me in some messenger.)
I will drop them from the pinctrl tree.

Yours,
Linus Walleij

