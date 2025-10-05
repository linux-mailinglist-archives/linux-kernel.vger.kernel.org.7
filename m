Return-Path: <linux-kernel+bounces-842434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30245BB9C99
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 21:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15FF34E414B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 19:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074FB1E32D7;
	Sun,  5 Oct 2025 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnuYQTmn"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2501DE894
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 19:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759692974; cv=none; b=DbDZYITk/9RYnKmwRQ5WRcaXUbIj3quP/kOobNxRfNwoXVl4zoH145Dopsmlloib5QMgS3DYYlVvUzpg5XBLH05hlYBUn3EsE8aTc/vpnGQrKZ/DlQeNB2d2ZLGYWLkV72uFn63X2zyXjexHC6qO7ZIdMJCriFw4TIXETy88+zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759692974; c=relaxed/simple;
	bh=HpCPwTV6Ymso2jLvEaOmKrvUbLjDDf+rF1XltKBbEo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOfQ3Ju7kIZt1l5H/k6xJmVMQnqcEZGmn/khcVImT6ARRgnvEmq9E/tonsVBlw6OaGh37/87eaUretfE9hzvul6/3f+09nhyF496YwL8LibuuD7JZexFp5vJ7b1H5UtuzEwAW9XYEdnF1QxqY5Ij9707oZnEUiGMalwqPXh4qCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnuYQTmn; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-58af7f8b79dso4511810e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 12:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759692970; x=1760297770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B8ByiJnX+QP06S+C98Ev13SN/Q5Wa0f7/4hHRsHwc/k=;
        b=FnuYQTmn26+cBaC0AwP1dStC58+OZP1x5qrT/Ikq2HfFvgfel66g3Co+QjS72KOQbT
         BWdRp3XPT/vPU6s2SQUjhTUe7CCgiMAn/zMEFHEKe7/Uv26Nu2QJ6kAzrKBnKR86T4bx
         n9VpBw4ns6NN9+IHH1bH39cxhhEGVy9sgrFG58yUG6l6DkAsiK/8ztdJYoc4oZGnSweh
         8DB8ApsS4grL4flVePSv1g081o+CEs2C0MHyl78b50rYaH4Wco/zi5Acrtq+6ieR0Cxv
         NjHgoNwPHxOBlARJpkTP4SB/fahH3VEj6PIHLOD0zhhFt+prFEvuzHfk6jzNExRW6bYh
         Yzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759692970; x=1760297770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B8ByiJnX+QP06S+C98Ev13SN/Q5Wa0f7/4hHRsHwc/k=;
        b=DS8GRHoP5kO3gIEqkA8Js7C+NQk1Dcn5Kr4GFen4EN7RbVTsjKSWgCAqKXncjA3clf
         h0oRiMZY5ftKfrGL1VekND4iydpjDJe0fz/8BKFNlZGwsyJN42jBDuO6k4AnKGLM/Bua
         CejJG6Ce8Z84Vpc3ijNPWhEJG4CgArqqkzWs7XQIQbtgFnkNUsrUnZOdFYZLZx5A8P/0
         HeDmYs34do5/4WL7aPnCEwXI9ad72OmSOZimktBW6l5XEsrmY3Tm7tbt9BRKvtMwnA/e
         OS7ROv+aO4s9n6Q1J3sPbXAhuEcxTIdldKXKAfqyjj+JgYKkeX7zvS/ujqAODJZa3KO9
         KGPg==
X-Forwarded-Encrypted: i=1; AJvYcCVJrVS7C2QzEy9LmA/BINokdeDUa8fSvEwlkVCHQHYuB/EOylEJWUvYYrEfC1K+g8PKxIL05J/mwx0K0Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkW2jLdPTVHxJjEt83mdWPWHfheRUwMn2j3bfzCF48akzJaRl+
	T7wg+m29e5qyuZONtBuQ6HMiGm0aGrmR7yOfJ5zlHZUWZldpvQacd/MAa+CmX+OljP9dbiJF1Sm
	e4DkQ6XbbkJ8gfxkRNbgCTByFbSbApG0=
X-Gm-Gg: ASbGncv8ovp8m6lyEZDNvp4SzuGH9F7+GV+LoaKMfM/80QPmmbFufj2FPMhjxN3W2uV
	TNEDOlPv9UKRSmv9vB3u8qZQAZ9H4Pk+C+h5YBn8JSX1LDdtAGy6Y+9lPBbSf8GxygnSD5T9bVd
	S62UGv2ukOMgCr0Yy/0FHj0rjCcgeFBw7z515PoaqoHfrHCJJIIlUh2f916NUT57c126fzDw5ku
	91012++1+uKy0hAEk9EZ7MbIE2lXn55nET4gqvQcPinf+yTuGw7SWCpehqYvBVP0Sp3dgdlcCaO
	8J28N0DFfSlLEVsR+GDwramxjfltzBUbqYX+wEzzMzxuHc78/AKTaR20ZMz6TIbhCyNW1X+RiKs
	8VZCq9qU=
X-Google-Smtp-Source: AGHT+IGeuKU8klCmxB4Wd39ZsY1VEQw2A/8b61XgTuTEMmx63wy7XwkjXnKRo8krqB/HqCUkM+y01HIC7xEEEyhzQ+g=
X-Received: by 2002:a05:6512:230b:b0:585:1ca7:1b7b with SMTP id
 2adb3069b0e04-58cbb255fcbmr3402254e87.31.1759692969485; Sun, 05 Oct 2025
 12:36:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928-judyln-dts-v3-0-b14cf9e9a928@postmarketos.org>
 <20250928-judyln-dts-v3-9-b14cf9e9a928@postmarketos.org> <42463474-7fba-4df3-9dbb-24140581690f@oss.qualcomm.com>
In-Reply-To: <42463474-7fba-4df3-9dbb-24140581690f@oss.qualcomm.com>
From: Chris Brown <crispybrown@gmail.com>
Date: Sun, 5 Oct 2025 15:35:56 -0400
X-Gm-Features: AS18NWD0klMI-Y0ok5kdj815WG__q8Dt0zdKpCJrqe8wE9-WN-Ydtjc6OrnZJzM
Message-ID: <CABN5=wEpekmKxFCr7nBcYGSt6ZH-g+bx7Y5Nmoo=tMrorz2XBg@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] arm64: dts: qcom: sdm845-lg-common: Add camera flash
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Paul Sajna <sajattack@postmarketos.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Heidelberg <david@ixit.cz>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
	Amir Dahan <system64fumo@protonmail.com>
Content-Type: text/plain; charset="UTF-8"

850mA looks correct for the flash, whereas the flashlight/torch should
be 100mA based on
https://github.com/EmanuelCN/android_kernel_lge_sdm845/blob/U/arch/arm64/boot/dts/lge/sdm845-judy/sdm845-camera/sdm845-judy-camera.dtsi
i.e. led-max-microamp = <100000>;

On Wed, 1 Oct 2025 at 05:04, Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 9/29/25 7:05 AM, Paul Sajna wrote:
> > So it can be used as a flashlight
> >
> > Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> > index a8c8706f2057d36d5ef4130f11d9ad417f93d575..f309e6ebc075a691c7a522238b4a93ba9e63f3c0 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> > @@ -509,6 +509,19 @@ &pm8998_resin {
> >       status = "okay";
> >  };
> >
> > +&pmi8998_flash {
> > +     status = "okay";
> > +
> > +     led-0 {
> > +             function = LED_FUNCTION_FLASH;
> > +             color = <LED_COLOR_ID_WHITE>;
> > +             led-sources = <1>;
> > +             led-max-microamp = <850000>;
> > +             flash-max-microamp = <850000>;
>
> Allowing the same current for flash (brief on/off for night photos)
> and LED (flashlight which you normally toggle through quick settings)
> sounds no less than suspicious
>
> Konrad
>
> > +             flash-max-timeout-us = <500000>;
> > +     };
> > +};
> > +
> >  &pmi8998_lpg {
> >       status = "okay";
> >
> >

