Return-Path: <linux-kernel+bounces-860391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA5EBF0073
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C47A134A765
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDD72E92D1;
	Mon, 20 Oct 2025 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcQTBcr9"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADE62E972D
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760950263; cv=none; b=qa2YqAohg9DznqTRITrY68LwaQfTGVdnMfRBQuQ3w2r7wgSF3PD+KQbdDeIQQupolugieCS5nU5DYuR3GsoyOOKd4IT9b0hllScLnxizZYU/1q4fEIIpkXbe6Bn3yHH8hFTO5AMpV0qS4K/g0LArRJj199yKDMiFUDRA/rkRfSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760950263; c=relaxed/simple;
	bh=mkvZFRcpCPts9hzzqprApnyLhy/tAQUrmcPdgUB3zj4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ty+iJnKsTL5AxBGKqOwy6VPKcJ01uSDbjVRXVlW0zgr634IC5bVLbiq8YtiC5vLRxA3oCbf0NI1oQxPJ+V9hBowjtuNB4uBQhSOdXSBy7cfO4PJ8YFfE3DclpKIKx8sz2y+xYqXBBXEGfxSU9T8BZaRQ8tG2dDCvjVlYRdr0Dkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcQTBcr9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so3021480f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 01:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760950260; x=1761555060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2yGmBP/PkMxgu2wwxaNLMOWwQSg0wFQ20D8HmohcvME=;
        b=PcQTBcr9UwDPggCx/W0mJRfdBQShLH5w5rI0+yAb/J6tYH4OEgpWOOyNsH61aSD5Z+
         Vp0AZ17/kRulZs3GlNTinLideC9aCUpqRY/QUOb/MoP516m68vojQgbL3AUrcW2Ll4fB
         UvAV34C54F5aBNolExOVnDybIoOHLjKRaC9NHDt4xNEd5gYQ4CTrlpZbK5bajx7ZF5tJ
         KFPEUwb1n0rKONFh6vxBY84yd1hweZGOeP5axbcEdUi1VNreGBLQjVwZ+0Jt8jzqU1NH
         i9j4kLx72f4DhkuZrI+/FQJo2aF+Xm6I9u8jF70vitRqZrlixpdCW4ASXjWGrHyAqigk
         qXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760950260; x=1761555060;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2yGmBP/PkMxgu2wwxaNLMOWwQSg0wFQ20D8HmohcvME=;
        b=WrwtW1pT9gemIboQif6h0C5YKMlJOHbOX9VvzH/IdvajfJXv7Mu2nNL4RDrlnauNd/
         VoL4XFW2D2WI7dnFhlSh+DDf3rEpLftTCGb39dPD3os5Qd0ftuEKihwsaqY/dpwY7I33
         EV7otFRowtjMvQoGCIs8gkPDSox9+r9OncHcRzRcYPrtHmtDMguKZIaSes8TdztPVaz/
         xRWAK7dgLbs/7bj8cxf17TUPXzr0Ykb70CqOWL9Wsg2/25jW5mitLgvZxEhlrId6petK
         2cXgRAas+X+0fbtfjIGoeaMX3WtNhiLElzfi+bsF9OgBM4Bwc6t+upjfmZdBlNy4daLB
         uRzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU7pTGaqQTfnfepf6+JXNmeTZv2ByJbQvGlMmKCqGztHfKm0seHd3Y1RK/uuscnwSv+Kz6fcG3FyKL4eY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeW8MIBF6nRJTHufDsluod6KesNd+Q4BgRwDHoRQCSpghK1duL
	OOR9ULuFIDymjd53GauRBjiEMYAdiRBIc2msPO5xY8KTZA0UDMgvd64Y
X-Gm-Gg: ASbGnct83DihW0Zl09C6NHaUwtOHtGEt59pJ27jqF2icV5AqsBeOu2oQGdumOHAc5al
	3JXSpOhwjYXcs0OSCPUUndhMbkHsRbN91DHNrzgfp0YVIHgyXbdInGKBz03W3Z3lj88z1chq5fa
	13fPQzhKLYkTltTgHwNpGkph7RZMRNQtgZfNEoHSOPOW1SiOct7PtxXSRPdnaaFgirl6x5JRtha
	fN0Qjldj7mlLTJpXt5tlMgqC6L3MUuNtug1+5F0+g7yUwyRYudg6fnzQqo06qDUygZgX/iLpxqX
	PFybBpHSJ4mws5E1LzVsIMts9SkxtIywW9rcvyXFFcuBOveaji3Vj50wpPBa+0rpCFydKw7Qgi1
	5lw1dFAlbvUnVpJDUS/x/SEV6GCFLNKC65cM95WpLT8F0lotTpBaYMu/HtxfWlJvaBHIwCMOmKM
	IR6h5iZQXbmBMU+tfw1luSwNBRatpmerGvYxiiHxWBEjziuMF9Gw==
X-Google-Smtp-Source: AGHT+IEZuzT5Fi6RwZkG3ZCBMeU/nFGgDtAhgLPA7LKZMuxVJQUCCBR14TWol1dcQMMPKI5tWNEmrQ==
X-Received: by 2002:a05:6000:1848:b0:428:4354:aa27 with SMTP id ffacd0b85a97d-4284354abc4mr2871879f8f.46.1760950259658;
        Mon, 20 Oct 2025 01:50:59 -0700 (PDT)
Received: from ?IPV6:2001:8f8:183b:9829:50b9:dafe:ddca:3ba4? ([2001:8f8:183b:9829:50b9:dafe:ddca:3ba4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710f29b559sm104370685e9.8.2025.10.20.01.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 01:50:59 -0700 (PDT)
Message-ID: <748fd61a-31fb-436f-b028-b47807a4860c@gmail.com>
Date: Mon, 20 Oct 2025 12:50:58 +0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alexey Charkov <alchark@gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Add DSI LCD display on rk3576-evb1
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250925-rk3576-evb1-dsi-v1-1-c76fc3740abc@gmail.com>
 <CABjd4YwVfrzxYKM4cAG=-fMbw9OcQGZD20CVCG8FvC8phDsw+Q@mail.gmail.com>
 <5143458.iZASKD2KPV@phil>
Content-Language: en-US
In-Reply-To: <5143458.iZASKD2KPV@phil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On Mon, Oct 20, 2025 at 12:31 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Am Montag, 20. Oktober 2025, 10:19:51 Mitteleuropäische Sommerzeit schrieb Alexey Charkov:
> > On Thu, Sep 25, 2025 at 12:38 AM Alexey Charkov <alchark@gmail.com> wrote:
> > >
> > > Add support for the Rockchip W552793DBA-V10 LCD+touchscreen assembly which
> > > comes physically attached to Rockchip RK3576 EVB1 boards.
> > >
> > > The display part is driven by the on-chip MIPI DSI controller, and the
> > > touchscreen is connected over I2C.
> > >
> > > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > > ---
> > > Note that backlight support is left out for now, as it depends on PWM
> > > support [0] which has not yet been merged.
> > >
> > > A workaround is simply `gpioset -c 0 13=1` to set the respective GPIO
> > > pin high and thus to light up the display unconditionally.
> > >
> > > [0] https://lore.kernel.org/lkml/20250602-rk3576-pwm-v2-0-a6434b0ce60c@collabora.com/
> > > ---
> > >  arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts | 89 ++++++++++++++++++++++++
> > >  1 file changed, 89 insertions(+)
> >
> > Hi Heiko,
> >
> > Any thoughts about this one? Can we perhaps get it merged for -next?
>
> Does the gpio-backlight work on that device?
> That would make the gpioset hack unnecessary.

I've got a local patch using pwm-gpio and pwm-backlight as a stop-gap 
solution, but I don't think it's worth merging upstream, because the 
backlight is supposed to be driven by the hardware PWM on the same pin 
(not bit-banging the GPIO line). After all, Nicolas has been working on 
adding a proper hardware PWM driver for RK3576.

The display itself works without PWM support, and so does the touchscreen.

My temp patch goes like this:

---
  arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts | 15 +++++++++++++++
  1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts 
b/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
index f20cd6f2c079..5c27fff03569 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
@@ -58,6 +58,14 @@ button-vol-up {
  		};
  	};

+	backlight: backlight {
+		compatible = "pwm-backlight";
+		brightness-levels = <20 220>;
+		default-brightness-level = <100>;
+		num-interpolated-steps = <200>;
+		pwms = <&lcd_bl_pwm 0 25000 0>;
+	};
+
  	hdmi-con {
  		compatible = "hdmi-connector";
  		type = "a";
@@ -78,6 +86,12 @@ work_led: led-0 {
  		};
  	};

+	lcd_bl_pwm: pwm {
+		#pwm-cells = <3>;
+		compatible = "pwm-gpio";
+		gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
+	};
+
  	vbus5v0_typec: regulator-vbus5v0-typec {
  		compatible = "regulator-fixed";
  		regulator-name = "vbus5v0_typec";
@@ -277,6 +291,7 @@ panel@0 {
  		compatible = "wanchanglong,w552793baa", "raydium,rm67200";
  		reg = <0>;

+		backlight = <&backlight>;
  		iovcc-supply = <&vcc3v3_lcd_n>;
  		reset-gpios = <&gpio3 RK_PB5 GPIO_ACTIVE_LOW>;
  		vdd-supply = <&vcc3v3_lcd_n>;
-- 

Best regards,
Alexey

