Return-Path: <linux-kernel+bounces-712048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6F0AF03E4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 21:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65AE51C20ACA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 19:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6E4281531;
	Tue,  1 Jul 2025 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jjGn1ARo"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51801274643
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 19:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751398550; cv=none; b=DmFXMEWNzft67PGYSnsYQjcbOLgE9rtzuf9zMnnMjJfQAOQmgWso9NAcSzahE6AJmaRO6HdJ+PcR2YHfXCrKwj0BoTvzgrbzxz7d6e/GnkOnfwi3xKYJfdY+cXmWG51BhTGuWrkprTzgRDOeoALmOqzIBHHcEIF03cRQUtDGEQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751398550; c=relaxed/simple;
	bh=+pmAczIoAz20Sgyz7Pn5reSR+IXgzDoQvoDClC/I1fA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Y9OtIb04SsBexOldl4AdTm1j8o0F3HMMcA9mjTdwf4PDh/Cbnh35V6OkwuehfFxaaZCBeNLhCjKSffbGtIDoUk0hC+83dcRp39rA7PEaPxgcy7Yjkh4drOm6HXvuHWPzkThHaAg8JpN93YrZjxANTolMzj8W61UVe1DzHihKRSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jjGn1ARo; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a365a6804eso3253686f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jul 2025 12:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751398546; x=1752003346; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aN3BX1N8+BC+t/ow8nynRNiXWtKajXyZjEmDVu5QSCg=;
        b=jjGn1ARo1MsU+akd6WRW9IjHuImBmWNFv2vepbSukxS6f12bHEAcumOAAHZkARzqSw
         9aanTQ5RFELV0iCfIHvbzKj9Ufr/st7tZV9Uf/BO9ugU84DhRG0v4rQzlEdbJ0c/ynzd
         ngsbtHrFuomWbEqb+X70evJCYMtlj9lPh/QE7MSyfam0q2B96lGLkEXG9Qb3yTekxCZl
         xRe78oiusTQu95RVrsUIVTUFr4a04IAQRj+kt4dpXaRDk7D5ZsJKaXsF4Ay/FzuSQ94K
         JTXtoqrX9rvvPaTbCm+vHEZQmyz8LFBBjveKJdNICwtL1+5vmV/mEwXmGHgpksdk3DC1
         EKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751398546; x=1752003346;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aN3BX1N8+BC+t/ow8nynRNiXWtKajXyZjEmDVu5QSCg=;
        b=LW41+0aCUMskyAaaOq1X3KFZAFrNdV0AjjnCXolk6M7WBCZ7fAEK1xGZRfcQh/r+BM
         TdMHnKXq93BQwNECwayR90l7TFHXaXjeuuJ5ZHsxhF6ViDF1V2RskGIctPN5sxF4+r9k
         Ot3O8SkvHfFMsBa9vXxUEN+uTy56UStINhqKbUm8VUukRwxRe7MC+2qpAJK3nhPEznlZ
         DOFRPlUN4Zt7cLRgtpem+N+O7PvfJKtF6WE55M19zMMhWo+rui5MH0wCZXQn6AOLtLYN
         yqezAJw+L/nxy5BZnH8LjSsIZNiVGvgvaZX87Ux5ZQ9OTvaT2h89ZQh0bgw9mQwoT1OU
         51Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWmJD5DW8SxNRYBzCuN88fmuPRuOLrWbN+BACoLB/WQvHzDNgWAIEgm2vQg8nMQvHItcK4+t19wdfVHO4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YznA2z6nG0YXbzc32EwhIt3fFEa3WO7cmkfEd+nTg+XrMd7r96w
	y39dD4TH8r9TZ2IDRSP8j6TuMsG4UPsR+68Vu9nxDVWRdQ6mG2F/2XHfcmrgG9raytY=
X-Gm-Gg: ASbGncvPLbmEGmy9AYXgxoTZhum/A97wIz9wPZ3ABoDmHzbEKp9duqzmMWXBX86sSCo
	W8NgevfnIo+5OddzmIm88OQKNrmwKPg8g7wBEq39n8PnR8LKTt1Siga8jpX/feeaF6OkiGJLtdW
	uD30bSRtrSiQtSbnRJZPqJtdtB0MTSqzt+1/4WpSxKB2Cgoo0Rz5s9qaDjb4MHqLRPMonQ6+uiI
	gbgDFUjCQ/3Nx7ScH3mTE4ld+FBnSjEQLC5syUHfbDt1rqYOVwMcozD1XaX0nP7bE7/jx2w1bLW
	fbBR+po+9YqS775kDJt0liz9deNxtHY9KLwy/kqmnEbry0WnrhLzp/9GEF+xbH4JAjcM
X-Google-Smtp-Source: AGHT+IHKNKmkuKmDbrMhk4D/Fosqh/fvD260/xNJ3I/m+eUhB036LtpCqopLJVCj9MPeocJBMoTfxA==
X-Received: by 2002:a05:6000:440d:b0:3a4:dcfb:3118 with SMTP id ffacd0b85a97d-3a8fdb2a65fmr11528022f8f.10.1751398545560;
        Tue, 01 Jul 2025 12:35:45 -0700 (PDT)
Received: from localhost ([2a02:c7c:7213:c700:4dad:b69a:9c81:2e57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e61f48sm14258924f8f.93.2025.07.01.12.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 12:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Jul 2025 20:35:42 +0100
Message-Id: <DB0YYV10UD2Q.M36VAZJOVE7V@linaro.org>
Cc: "Srinivas Kandagatla" <srini@kernel.org>, "Liam Girdwood"
 <lgirdwood@gmail.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Stephen Boyd" <sboyd@kernel.org>, "Lee Jones" <lee@kernel.org>, "Jaroslav
 Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 <linux-arm-msm@vger.kernel.org>, <linux-sound@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dmitry
 Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Srinivas Kandagatla"
 <srinivas.kandagatla@oss.qualcomm.com>
Subject: Re: [PATCH 3/3] ASoC: codecs: add new pm4125 audio codec driver
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Mark Brown" <broonie@kernel.org>
X-Mailer: aerc 0.20.0
References: <20250626-pm4125_audio_codec_v1-v1-0-e52933c429a0@linaro.org>
 <20250626-pm4125_audio_codec_v1-v1-3-e52933c429a0@linaro.org>
 <aF01gRFjsKgy6j4V@finisterre.sirena.org.uk>
In-Reply-To: <aF01gRFjsKgy6j4V@finisterre.sirena.org.uk>

On Thu Jun 26, 2025 at 12:56 PM BST, Mark Brown wrote:
> On Thu, Jun 26, 2025 at 12:50:31AM +0100, Alexey Klimov wrote:
>
>> --- a/sound/soc/codecs/Kconfig
>> +++ b/sound/soc/codecs/Kconfig
>> @@ -297,6 +297,7 @@ config SND_SOC_ALL_CODECS
>>  	imply SND_SOC_WCD937X_SDW
>>  	imply SND_SOC_WCD938X_SDW
>>  	imply SND_SOC_WCD939X_SDW
>> +	imply SND_SOC_PM4125_SDW
>>  	imply SND_SOC_LPASS_MACRO_COMMON
>>  	imply SND_SOC_LPASS_RX_MACRO
>>  	imply SND_SOC_LPASS_TX_MACRO
>
> Please keep this file sorted, there's obviously been some things missed
> but please don't make it worse.
>
>> +obj-$(CONFIG_SND_SOC_PM4125_SDW) +=3D snd-soc-pm4125-sdw.o
>> +obj-$(CONFIG_SND_SOC_PM4125)   +=3D snd-soc-pm4125.o
>> +ifdef CONFIG_SND_SOC_PM4125_SDW
>> +# avoid link failure by forcing sdw code built-in when needed
>> +obj-$(CONFIG_SND_SOC_PM4125) +=3D snd-soc-pm4125-sdw.o
>> +endif
>
> Other drivers sort this out in Kconfig, do as they do.

My bad, thanks for pointing it out. I'll change that.

>> +static int pm4125_micbias_control(struct snd_soc_component *component,
>> +				  int micb_num, int req, bool is_dapm)
>> +{
>> +	return 0;
>> +}
>
> Why have this empty function which is only called from within the
> driver?  At best it's making the callers look like they do something.

I tried to make a minimal working version that we're going to
update with more patches during next submission.

Right now there seems to be at least two approaches:
-- pull in everything and send it in one go. Srini said that it will
be much more difficult to review due to the volume of code;
-- provide few patches that iteratively update the initial one and
add more functionality. The similar way when wcd937x was posted.
I counted there 5 patches for wcd937x. We probably can do that with
this audio-codec. In that case I need to figure out the right way
to split it.

My main issue was MBHC part -- it is needed to avoid IRQ storm
from pdm watchdog interrupts but MBHC requires more things to be
added for its support, that's why there are some empty/placeholder
functions.

What do you think should be the right strategy here?

In theory I can remove MBHC and make much smaller driver but
it will suffer from IRQ storms with some kernel WARNINGs generated.
Or maybe I should remove watchdog interrupts from it as well.

>> +static irqreturn_t pm4125_wd_handle_irq(int irq, void *data)
>> +{
>> +	return IRQ_HANDLED;
>> +}
>
> Why bother regisering for the interrupt at all if you're just going to
> ignore it?

This approach seems to be inherited from older wcd-family codec and
wcd939x.c (wcd939x_wd_handle_irq) provides this comment that I can copy
and adjust here like this:

/*
 * HPHR/HPHL Watchdog interrupt threaded handler
 *
 * Watchdog interrupts are expected to be enabled when switching on  the HP=
HL/R
 * in order to make sure the interrupts are acked by the regmap_irq handler
 * io allow PDM sync. We could leave those interrupts masked but we would
 * not haveany valid way to enable/disable them without violating irq layer=
s.
 *
 * The HPHR/HPHL Watchdog interrupts are handled by regmap_irq, so requesti=
ng
 * a threaded handler is the safest way to be able to ack those interrupts
 * without colliding with the regmap_irq setup.
 */


>> +#if defined(CONFIG_OF)
>> +static const struct of_device_id pm4125_of_match[] =3D {
>> +	{ .compatible =3D "qcom,pm4125-codec" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, pm4125_of_match);
>> +#endif
>
> Why does this compatible exist?  If the driver is instantiated from a
> as a Linux software contruct it shouldn't appear in the DT.

Could you please elaborate a bit more? Should it be instantiated
as an MFD device or platform device?

As far as I understood we need references to soundwire child nodes
of the codec (which are in DT) hence this one is described in the DT.


>> +const u8 pm4125_reg_access_digital[
>> +	PM4125_REG(PM4125_DIGITAL_REGISTERS_MAX_SIZE)] =3D {
>> +		[PM4125_REG(PM4125_DIG_SWR_CHIP_ID0)] =3D RD_REG,
>> +		[PM4125_REG(PM4125_DIG_SWR_CHIP_ID1)] =3D RD_REG,
>> +		[PM4125_REG(PM4125_DIG_SWR_CHIP_ID2)] =3D RD_REG,
>
> Data tables like this shouldn't be in headers, they should be in C
> files.  At worst you might end up with duplicate copies in the object
> code.

Thanks, I pull in a change/patch that fixes-reworks this.

Thank you,
Alexey Klimov


