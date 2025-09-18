Return-Path: <linux-kernel+bounces-822121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA5DB8310C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 810077A2D19
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4592D6E7D;
	Thu, 18 Sep 2025 05:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyV3OBci"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013E02D6E7C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758175112; cv=none; b=XqbJgQj1E4FwUBoQaH+LFRF6PxQYgKLZutfwBZvTG3MnE0CBHj7CvfKL40tfIZJCskHol6xI+J1s36RT2Q5lPhoUoDFwWWmyEhhSMyaMpYEp840T9rzQsYIpnCHwMvOhetw083Lb0o+eEV7KQrBktIOPeN56gQMp14gvAXQW3+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758175112; c=relaxed/simple;
	bh=e7yRxA2B68UWIKkdczYYijQsT9ZC4h4tFwI2brifv3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyK15P4CIt2hC1kV2dK+u0A3bHOofC5B5QWc73GdnuIGDbXufOIsaMNmfLDQCG60IK630VoBy97t+SaLSXCBjrUcZyhCWp1dBuAIJJ9/FG4XFz30+0bZtAf/edCsgTBlWexpwZjfEL4YHJD8dJXTmKLiN0YDVsTWAnyrmUxINwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyV3OBci; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77287fb79d3so594166b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758175110; x=1758779910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1M8K/x0sWMdi+p7zlur7P/Abek/ld1zdxtrufjSounw=;
        b=TyV3OBciB6qhzJ4DdhcCjulEYOnOExKqaLoQAsOiTfqpMJMwVuXNZWAYksnXfxBXqT
         1Y8zu/glvqt9pd8bJOah8UvJMmL06zfGb0cdh//qOHw4NxaFbiJrdFooqKkHgxdn91hD
         EtbCeHaxl4naGo4FbxipOHoMuUufnoM/x3eiQoVZEyIqkJJE4qnvvBLbusOTiGpcjmcB
         EvtJ67UN6uk32YgrA25u4W/+vRkvgkUr3YLwIWGD23oOWbuU9aqHR0yJL6U8GaiI1RHs
         XbFA77Ykaku74TFvngzrM08k6voUHeIetAT9cHlsQxetKZUv9QyshrHB+DlMrmMqCwGd
         EYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758175110; x=1758779910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1M8K/x0sWMdi+p7zlur7P/Abek/ld1zdxtrufjSounw=;
        b=YH9i92mnUPXhWrlpi7h6xn1DrDc3st5eNs9wUHFdedTg+4Jg3APIAM1u9Yt1X0/vJY
         mI9Aeb/9GzbjEW0P46EIgfJLkkoeMi5xYfiV/t/C9POmmucgXPAf3ImIthHDCMkJy8lc
         maU8xMif29SslduxjVynlXsHAsBUFPhY34A+0w9TJX8ZKQiYFtdcxZ6dPkeHl5DvpMDN
         wbFf8t0VcRlwIDlg/PA0vqfM2bx2c9At47sB86RAG9s9sZJc6MBII9yzVhoo4rccJI9e
         tSh0a1S70ZMNVXNF56SkhKlrkUrJpasa7xqW23cqisuZa8MsHWcVPmrhuRFQborD0vAy
         vUVg==
X-Forwarded-Encrypted: i=1; AJvYcCWGRWvZlfG24a8/08zSBQ/uDvyMogvlXeo6WouNQwrJnoM1zeHtUmabqToWlUuG0gtkhc8duqrueAN9qPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCwY+MZgjI6N69r1FoyYKJex9N95Z4IhTNpOi6A6YOQ6+6flj2
	e+DeUr1AdT2hoo9cIz5xe2x6cINPa36a+uxfcP0ZJ7NXNeYtno+fEtQMheT+Hw==
X-Gm-Gg: ASbGncvOEJaxuxUaPpcz7gLvd8BskCM3V34d8PAp6YXQOOsk6u5zJfqHvvhOS0am1V8
	NDXsko/GB/AotVjHMVRgwVeQA1HDg65I7TONrPUkpr72HwZ0bEZ0R7LoyMdLWCiMDT/Ue8o7j00
	s2R4hEe5VXo9F16y5/9kQLbuYoZ9Cgfcn5y9C1Q4DyI2+pLiEdiaG9ZQez3btv22yhbwvEnlkmH
	SxA9pooisW908RcDxZb9rzFEFJz6rDWEaUky0vYcBGHMhkRAtFn2XEapmdg1Kt9XOeNCpM7O5Eu
	8zBPQ0smF1kEoSkRLbeisDfDJowCXtAUg1TGafIbEtqkD2qZv04L09/RC5bZIh4DloCuswuEwt4
	m9K+e1ju51bLp/I4VALOtgEWb4XSywW+5iFURx1a1oQ==
X-Google-Smtp-Source: AGHT+IGb+rdTMfwVbcT/i/JK1WiLKpQvT7aq4HHFKHQrPydPEVY0k2OXSVn7CE/ZKWO3IERNaHMXMw==
X-Received: by 2002:a05:6a20:748c:b0:271:cdbb:4d26 with SMTP id adf61e73a8af0-27aac3da5a9mr6725643637.58.1758175110263;
        Wed, 17 Sep 2025 22:58:30 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:194b:8358:5c91:3d3d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff4002edsm1199838a12.33.2025.09.17.22.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:58:29 -0700 (PDT)
Date: Wed, 17 Sep 2025 22:58:27 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: touchscreen: resistive-adc-touch:
 change to unevaluatedProperties
Message-ID: <wbwtlcrlwnvvjyv7cnffu3sltrqfaddjf5f6dzizhgglwskjgb@zgxjfm5oafxz>
References: <20250910224402.994046-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910224402.994046-1-Frank.Li@nxp.com>

On Wed, Sep 10, 2025 at 06:44:01PM -0400, Frank Li wrote:
> Change additionalProperties to unevaluatedProperties because it refs to
> touchscreen.yaml.
> 
> Fix below CHECK_DTBS warnings:
> arch/arm/boot/dts/nxp/imx/imx6dl-skov-revc-lt6.dtb: touchscreen (resistive-adc-touch): 'touchscreen-y-plate-ohms' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/input/touchscreen/resistive-adc-touch.yaml#
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thank you.

-- 
Dmitry

