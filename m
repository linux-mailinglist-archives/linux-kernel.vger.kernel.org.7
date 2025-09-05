Return-Path: <linux-kernel+bounces-801995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2CCB44C8F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CB35A1E1C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54111EEA55;
	Fri,  5 Sep 2025 04:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9X3nXto"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA641E0DE3;
	Fri,  5 Sep 2025 04:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757044898; cv=none; b=QWgrnbF/8me/TGTz9StXJIS+7thahoKGw2Y4q0aGpXN3hDCcWGNy+N2G9zlO4reMX/Di0GH0Ge+EvcgIQgC7uzJN4GIAOwGCBQmNHaXpX1wleL7iRyj45FP52Pzvt0WvqG91VrKyZkJuSHMyVQ8Ghi9BdSCcWbqvG91Nenb+W6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757044898; c=relaxed/simple;
	bh=Y5UHBgVOjh02K86+IEXp4zDmoDF/+ibze6K/APHV/hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3UQ52OkSYd1VdiQa4/qOd16jfaOjY1ISKu4+zp6LAdfvT4oaP6qNc8F33GSv2JN1UCQpocwERG7GVYap5a44vVwvhAznuxd1uHSVPnf8gkhBZUKzY8YbwpyQcQTEPDZl1XtgysSb8YvAJFR21cV63X4OH1sNZ9zhogCmoEkQ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9X3nXto; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61e8fdfd9b4so3977860a12.1;
        Thu, 04 Sep 2025 21:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757044894; x=1757649694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YGmnk9Y7kDaqvngUdy9AiDHXDEmTlZrFIomlpm38Cxs=;
        b=D9X3nXtosj8vgBnZxDWjiUKHjvdzHyv8jdy0nY1WesvpLHaO/MzsrAsYOi8Tup7f3X
         PTvg//41gf5v6gAf2H0l1QmiEBtRxOo3HDD8ul93A+0xD1HE1SKESV1o8ySZK9rgMFb+
         Efk7anfV1jMD7T+4ByFUIaoeBCNHhLqkOr5MbrbrNsOT0McEneSuWz8fcfe46ziW21tS
         C91hVvbXqUnwmfsGkZNeT7GQi+u2qPkMNcMNudBexkymh4b5zuZu7BP3HspbBzF01waD
         mpPLzkIRuo6OMwp8/K9xHbZKyCLPGHOueAUK+c58/iaYn5uuOFkh7E/9rirRxcA2g+4/
         G3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757044894; x=1757649694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGmnk9Y7kDaqvngUdy9AiDHXDEmTlZrFIomlpm38Cxs=;
        b=rlfHVTphOMAn14+kplVLEi5PDB97Z9RTNn998p6YB/iPA3UPCIWJYiaZNPzUHllb5D
         k0URbrIGjIq8VqWEf8fOtlDy3RgIltcWLd365+o8MTTRYtYA6g82PZEFZCknKXuSAbeq
         aYFxr9utEMKfyNsiBS9eqpKVHOSPWIURaZGVioluVkTffYq4rZSUgT2IeMlYDw7lyOkI
         Ugyi+3JNqDU1t+lvODs6h1ucmOqAcVXhOn/YySbLqyKpe9zDIJgzXqbVjSbMelpvz+T9
         3iNsR+43Yo+hvqJiHqFo4hiLalo+f29Mu3F4iHt/ZsIC0UHaGLXabGw3NEqcfnOT3hQp
         wqnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV1AbQdl4b0Xk+BfHSo6NAGR3HqdKgx96Kj8LaZGpHQC6EcBXOg9Ultg+3bY/Cv8039e8Awg8WbInT@vger.kernel.org, AJvYcCWq+gZds8/Ki9gEU4U4JIKB5+cbddr3umyhdISZ74Kh4uHa0+/q5IQ7+kf5tFBhMnqaF0SSBUzOzG9fWwuw@vger.kernel.org
X-Gm-Message-State: AOJu0YzHROOKqyabxwjFQe0JzbjPIF99SfM1gG/jx39g/W0d1tan8msK
	mXWl/FPnQRHr2CcjBQALyJKglE/EI0qSBY8NrE+JUkQ+DHjButTf10i4S1eTuLkmjNGo162rv4i
	swcubK2oenpNEYXS50CSqyMHf3HD8WQQ=
X-Gm-Gg: ASbGnctvB6JDWDRfvYYB2jBDhD7R4+m5+uTY/Z3bCYVWFPjegtRKFGNfPeMYKiS+kEt
	FPkg6ziheqPjGFoZ53kgjktVKxmk11ji5WDuOh4AcLg6l/kk+UC75Vwv3LUyCICWM/ArFxfnwBm
	OC7Jtv4eIVyvQBFGk4pLWfdCLAx0IIenl2on8fR8DH5Flu/FAOAJ0mdA/1OS5RH1V+hUpt3+U8A
	lRvAJDlzvQw43ze
X-Google-Smtp-Source: AGHT+IGI90WvQ1OL6qzT0UTrxnDzkKtA7u7gnGXFuOteAw9bkUI6xf+wizPLY6+YzR0GtxSZAJQl+LWmGOlaRBQLAUQ=
X-Received: by 2002:a05:6402:430c:b0:61c:e3cd:a515 with SMTP id
 4fb4d7f45d1cf-620f549b25cmr1673091a12.9.1757044894512; Thu, 04 Sep 2025
 21:01:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825065240.22577-1-linux.amoon@gmail.com> <175699250964.3374853.16885676491827667777.b4-ty@linaro.org>
In-Reply-To: <175699250964.3374853.16885676491827667777.b4-ty@linaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 5 Sep 2025 09:31:18 +0530
X-Gm-Features: Ac12FXw6Duul3YjCrLSMtIq3Ki1Yxh-YbEkzS0fLz92JkUkwkfAjtBL1MXoQ11A
Message-ID: <CANAwSgQGCTs46DVm3gt4PpdSTBTvVg5zga_oBt=rUJh2yhRLtw@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] Add cache information to Amlogic SoC
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Neil,

On Thu, 4 Sept 2025 at 18:58, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Hi,
>
> On Mon, 25 Aug 2025 12:21:40 +0530, Anand Moon wrote:
> > Most publicly available Amlogic datasheets mention that the CPU employs
> > a architecture, quad-core ARM Cortex-A53 and ARM Cortex A55 and
> > Cortex-A73 and Cortex-A53 cluster, sharing a unified L2 cache to enhance
> > overall system performance.
> >
> > However, these documents typically omit details regarding the sizes of the
> > L1 data cache, L1 instruction cache, and L2 cache.
> >
> > [...]
>
> Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.18/arm64-dt)
>
> [01/11] arm64: dts: amlogic: Add cache information to the Amlogic GXBB and GXL SoC
>         https://git.kernel.org/amlogic/c/d7fc05da8ba28d22fb9bd79d9308f928fcb81c19
> [02/11] arm64: dts: amlogic: Add cache information to the Amlogic SM1 SoC
>         https://git.kernel.org/amlogic/c/fd7b48b1f91e1830e22e73744e7525af24d8ae25
> [03/11] arm64: dts: amlogic: Add cache information to the Amlogic G12A SoCS
>         https://git.kernel.org/amlogic/c/a4428e52babdb682f47f99b0b816e227e51a3835
> [04/11] arm64: dts: amlogic: Add cache information to the Amlogic AXG SoCS
>         https://git.kernel.org/amlogic/c/3b6ad2a433672f4ed9e1c90e4ae6b94683d1f1a2
> [05/11] arm64: dts: amlogic: Add cache information to the Amlogic GXM SoCS
>         https://git.kernel.org/amlogic/c/fe2c12bc0a8f9e5db87bfbf231658eadef4cdd47
> [06/11] arm64: dts: amlogic: Add cache information to the Amlogic A1 SoC
>         https://git.kernel.org/amlogic/c/2d97773212f8516b2fe3177077b1ecf7b67a4e09
> [07/11] arm64: dts: amlogic: Add cache information to the Amlogic A4 SoC
>         https://git.kernel.org/amlogic/c/57273dc063d5a80e8cebc20878369099992be01a
> [08/11] arm64: dts: amlogic: Add cache information to the Amlogic C3 SoC
>         https://git.kernel.org/amlogic/c/6d4ab38a0a21c82076105e4cc37087ef92253c7b
> [09/11] arm64: dts: amlogic: Add cache information to the Amlogic S7 SoC
>         https://git.kernel.org/amlogic/c/494c362fa1633bba127045ace8f0eea0b277af28
> [10/11] arm64: dts: amlogic: Add cache information to the Amlogic S922X SoC
>         https://git.kernel.org/amlogic/c/e7f85e6c155aed3e10e698dd05bd04b2d52edb59
> [11/11] arm64: dts: amlogic: Add cache information to the Amlogic T7 SoC
>         https://git.kernel.org/amlogic/c/e97fdb9b8a0f8bd349de48815694f8a7200e3d62
>
> These changes has been applied on the intermediate git tree [1].
>
> The v6.18/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
> for inclusion in their intermediate git branches in order to be sent to Linus during
> the next merge window, or sooner if it's a set of fixes.
>
> In the cases of fixes, those will be merged in the current release candidate
> kernel and as soon they appear on the Linux master branch they will be
> backported to the previous Stable and Long-Stable kernels [2].
>
> The intermediate git branches are merged daily in the linux-next tree [3],
> people are encouraged testing these pre-release kernels and report issues on the
> relevant mailing-lists.
>
> If problems are discovered on those changes, please submit a signed-off-by revert
> patch followed by a corrective changeset.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>
Received feedback from Krzysztof to omit the comments in the commit message.
Should I respin accordingly?
> --
> Neil
>
Thanks
-Anand

