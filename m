Return-Path: <linux-kernel+bounces-863274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA555BF771E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA0934E6A0E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D8933B951;
	Tue, 21 Oct 2025 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ryuKTo8W"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7048F339B5C
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061382; cv=none; b=XspX5F0z2qGn+Eo6ZubsYkmRFQWI9bZ5ed5PvuCSEKsaiq8zH2F6BADAU/lz+NluPQXxlefDDdh5t15Oq/IuzROrd2suGofo5JmjwZe93zDBCzcWayv12IIDhG+7DZh9SPCpZYFXC+NEhw1se5fP+OtTda/Ks9vhnqfzyzu7d5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061382; c=relaxed/simple;
	bh=75YAXkRpS5AYEhu5CiBSWx6SM3C/ihZP1jjcOFswJjQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Fs9ksQxkYCyCkHDj3r0lSRNK5BWpB8sdYUT6RFGMyjASX/6YNjyGFfnXRmNMCD2vKh8Rav/S/Tn2iwOZsFfA/2P6KfL6siGJ9KXSyQN+qrwPIDLoqNISADw4WEj2TkOaZYYe8BRTjkSoKbJw4tvNXQPQRcwYxB+jBuchX127TJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ryuKTo8W; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-471b80b994bso39647415e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761061379; x=1761666179; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhuCz+PGVZVkdCu2Fi23G6TX91sa3helKlTwcjtnmzg=;
        b=ryuKTo8WANBP2UwKrgzWZgGqU2v43XPXv1l01txN1LTT3+xHVQnLWTKPVrJaP8iamT
         FuehqICTzqWuU1cfq7yptj/g/C2ZBKv5PDdADz+olNq/oKYwzOIUIlh1bOG8+whT1CdQ
         GEctkBKY53F5GxoBqeYyhq948ZTzOC94fQNEboUHfgSJVVtjvCDZYVMH1iKr5AsOPbtz
         VEg/cVrR6Nqde3Slst1tffnTbUC11fiWQ3LvUr07R1OX4UMDkXdNFoWGQ+hzyDgVuQxB
         niuzsHCAREJ/BLpkQX3fX7lGh0lueEkUj9iHF44t47qChuUtAcny3w9cpU/C6B5CjpIM
         6vPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761061379; x=1761666179;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AhuCz+PGVZVkdCu2Fi23G6TX91sa3helKlTwcjtnmzg=;
        b=MykIBv865oNdMQnGroz/qgnbrvmOktIWlYHKvAXhGQzPUlx9/YnuU9wInA20iOwri1
         E7T89bXC4X1lKGk21App/K2lZVLXVRXb3ZPEMZQKG4VEBSYD8GhVfig6stAfwVa55YUE
         P4rwN2g00HFt//V9t6PuAJUXR2QkzZGSVLYqzBPN9tWD4tic3/VqxaxREC7O9O4b4wNY
         5jHctDdQlReMIuRWgCMd+BFcukhr18o1MbdKQPGIa2o6tRe3v88m3QZsUMrhRS/eM9yc
         qlRE2jFoGiVDNsh7L5ujRYExWu7wZuVZYp/8Xb7IHAF0YVCS/fWvVTMp0OFmsv3eBihw
         VUYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvTJMR15LSgw+jN9w8dw+e0r+RkNlt3e4T8dTL+winOm4hlVcU1fz0s1n/4exVLpEkZZPWC595Vh0AyvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc5WRDRbJhS8M6PKHDQsv66maSUyYnd0veVCndTAv4CcM8c2DM
	9ioi+1ZLPl88e3zRAoKqMUHnF47zVjGeCOvVGNCbUkPbq3/HhpDJqeeRt5Ee8jFis6w=
X-Gm-Gg: ASbGncshVjoR9WGQH6Qz4ydngqShDo9vPbFA2o8REoLv3akuXa3bgkb2D7GmRihxf+j
	mx11ERxFoWeqNNDM7rSocbg1nEMykOoTSyeye4rqZMNOk1ZW0rVfPLzMDTHrOCAkkT0rHt0pXpg
	i8/pSJIlFSrJMLh6lAt1HPx0JeVAYC3H6Jal/1u6PIxdGZIe/HqIq0DIUn7k3eC1KxIB+f+160e
	DHD0q2HdWA4ePYEF+f/ydsLLHQ0wUpmLAtzb1SIKE8Qdt7JlRXCpje43RIpFpQ9tnoMHSWMBdG5
	1VKSVLSSoxY5+ygPBnKasklXZXh0VWBLWX9JKd14EsLUfUS9nD5vkDKNYnZLVL1gy+JQGKQDSCB
	R+hQqqm8yQCMwtPzGQBbeKpbzaolpM5OY3ZIkOdXuUGgUlnWCzUG0DmRyoPvU7qJitFupChbwNM
	tYMWkL5JL/d1dWtx8=
X-Google-Smtp-Source: AGHT+IHp7MSIsvZ3s51V1ZsAKBgYboS1prMkRndq+IeFpziSbp+//AH/rUos6US1MvtXcjHxE4wiZw==
X-Received: by 2002:a05:600c:1d9b:b0:46e:652e:16a1 with SMTP id 5b1f17b1804b1-47117878458mr130704545e9.7.1761061378667;
        Tue, 21 Oct 2025 08:42:58 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:8d4e:2f09:764b:8b5a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-474949dd479sm21881025e9.0.2025.10.21.08.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Oct 2025 16:42:57 +0100
Message-Id: <DDO45O787X9V.1KOKIB22SVSN7@linaro.org>
Cc: "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konrad.dybcio@oss.qualcomm.com>, "Linus Walleij"
 <linus.walleij@linaro.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>, "Srinivas Kandagatla"
 <srini@kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: qcm2290: add LPASS LPI pin
 controller
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: aerc 0.20.0
References: <20251007-rb1_hdmi_audio-v2-0-821b6a705e4c@linaro.org>
 <20251007-rb1_hdmi_audio-v2-3-821b6a705e4c@linaro.org>
 <b6223af9-2d9e-4ccd-b297-79f63167242b@oss.qualcomm.com>
 <DDEN5NSLDIHD.C1IELQW0VOG3@linaro.org>
 <zmi5grjg2znxddqzfsdsr35ad5olj3xgwwt6hvkiaynxzm5z33@gsgrdguj563n>
 <DDO0LYS7UTEW.3A9WGTAA5DKVO@linaro.org>
 <56vmqgrjy3je7omzirxnfxtuocebbj356iaew5thgkagi35464@hh34y7efssow>
In-Reply-To: <56vmqgrjy3je7omzirxnfxtuocebbj356iaew5thgkagi35464@hh34y7efssow>

On Tue Oct 21, 2025 at 2:03 PM BST, Dmitry Baryshkov wrote:
> On Tue, Oct 21, 2025 at 01:56:09PM +0100, Alexey Klimov wrote:
>> On Fri Oct 17, 2025 at 11:42 PM BST, Bjorn Andersson wrote:
>> > On Fri, Oct 10, 2025 at 01:29:38PM +0100, Alexey Klimov wrote:
>> >> On Tue Oct 7, 2025 at 1:39 PM BST, Konrad Dybcio wrote:
>> >> > On 10/7/25 4:03 AM, Alexey Klimov wrote:
>> >> >> Add the Low Power Audio SubSystem Low Power Island (LPASS LPI) pin
>> >> >> controller device node required for audio subsystem on Qualcomm
>> >> >> QRB2210 RB1. QRB2210 is based on qcm2290 which is based on sm6115.
>> >> >>=20
>> >> >> While at this, also add description of lpi_i2s2 pins (active state=
)
>> >> >> required for audio playback via HDMI/I2S.
>> >> >>=20
>> >> >> Cc: Srinivas Kandagatla <srini@kernel.org>
>> >> >> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
>> >> >> ---
>> >> >
>> >> > [...]
>> >> >
>> >> >> +			lpi_i2s2_active: lpi-i2s2-active-state {
>> >> >> +				data-pins {
>> >> >> +					pins =3D "gpio12";
>> >> >> +					function =3D "i2s2_data";
>> >> >> +					bias-disable;
>> >> >> +					drive-strength =3D <8>;
>> >> >> +					output-high;
>> >> >
>> >> > I.. doubt output-high is what you want?
>> >>=20
>> >> Why? Or is it because of some in-kernel gpiod?
>> >>=20
>> >
>> > What does "output-high" mean for a non-gpio function?
>>=20
>> This is not efficient. It will be more useful to go straight to
>> the point.
>
> It is efficient. It makes everybody think about it (and ask the same
> question in future) instead of just depending on maintainers words.

No. Imagine instead of this email you've got smth like this:
"I.. doubt efficient is what you want?"

>> This description of pins was taken from Qualcomm downstream code
>> and the similar patch was applied (see provided URL in the prev email).
>
> And we all know that downstream can be buggy, incomplete, etc.
>
>> Back to your question -- does it matter here if it is gpio or non-gpio
>> function?
>
> It does. The I2S data pin is supposed to be toggled in some way by a
> certain IP core. What would it mean if we program output-high? Will the
> pin still be toggled (by the function) or stay pulled up (because of the
> output being programmed)?

Here the topic was switched/replaced. And the other referenced email
suggests that they don't want to see output property regardless.

Anyway, as it was indicated in my previous email the problem they
were trying to refer to was kinda understood.

Thanks,
Alexey

