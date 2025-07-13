Return-Path: <linux-kernel+bounces-729010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F703B03087
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 11:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1EBB17F704
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 09:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAE926CE06;
	Sun, 13 Jul 2025 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MoIAcGlF"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3373B229B12
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752400130; cv=none; b=ZB0nbDiZDgrqH8ITdeS0AVhYYBuXFf7xCuEYtNDCbpewKQHD8/5/3dCquAyiogiyDljb+Nj6qB3sWowzG7WONIlcotxY+7X3odQzjkf8FJgcsBJulplCmCTB6G/Y6oN5pOesDUldV4u/R7Y0sJBUI1nH5Poz8r0QtV7nd2OdR5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752400130; c=relaxed/simple;
	bh=vVRR7H+Oh1jOVVrd3OXMxD7IsYuOKBL4mwsfy0UVeI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYiZB/0OA3YZYvvQrYnOqE0Tctr6k/ohvBb4/y3Fmm4+XS8oNB03uWJlVsPkUKrKYUuB0TZ/WnZk0PMHewuueb7ESmsd8DjuY6PA08mCWm+I07GTyiG00sIfHnv605mvQCcCNOtzZEPbWqa0iDdaKB9UrVd227ikElMyXgFaF9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MoIAcGlF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45617887276so1368705e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 02:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752400126; x=1753004926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=87Y6uvJuNXy1ilBMxkL0pceOrA+vw3WvrJEYq2nI520=;
        b=MoIAcGlFM7FSdDXz2MBMNuOsZ987/BNbYTs/WK8T0ZNaLq76kR9f73XaaaarFPranq
         j5eEDcl4tNPUfgOLl3ddkbzEXyzawkQTrZPl6sxMdrnWXAUKIt2pzKk2FNSrR6JfjYHM
         9CHGodVbbRaMLz/TmGc3m1hgdghlxDjpgp5c4AsCYuXfpRUtd/ofUa5OqVJ0sj2XMA/v
         o/0buI+50YShvQ/tlhUu7TtPHD4/6g3NHvK9jkwJ4C4w/LNjLaGQNUNLTIgupKK9LMQA
         TkQXiHrY1AUPQIXeOW5891qA3e+xVV6a/elxPru1dTfrR9ehYH5CnYgE7VORTDBQREM+
         7N4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752400126; x=1753004926;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87Y6uvJuNXy1ilBMxkL0pceOrA+vw3WvrJEYq2nI520=;
        b=drLaEaKMm9odqO46FvIRoTQY0H7lHKDg2HyknktTdyFf0Yo2n0DYONOZHBkUxiQcWs
         NNSJ8GORo7Dh6oINxPUsLFohRHPzIcsAGTnreT3jYbBo+nCeU80+gsxns8bDBXbCzl8q
         KPbnp9vjN9S7sIAo5+u5jLDcLgrOa5EuBCSakREne2I5BqZ+lalpQIyWXlLut12oHu4+
         uGdjbvuhfdUJhkln0v14HKk4vuvWfQo1NhryYWzzfeJU+RzPj0/v0IORBRFPa0dSfGHt
         +D4aAPW9wPIS6cUr6I2rOrTBIpfyJLlW3haN5iQSf3Q0n6gCF1zHAGZgDjyA/a+gLRlP
         8xPw==
X-Forwarded-Encrypted: i=1; AJvYcCVISdbi6rmOC6jia0vI0hPv6fqqcKxC5XmO2NW5WsPjgZAoSaM6TeQOaxdfQxJ1IFFU5k/q8E5gSEBIo+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3zyW056OQjQbD6kb1ufH0cgqW8G7co3V0J74QdsdDp9/sQE/H
	edlrfxlvoE73aDRDiNuJPknsXpHd5g2m/Q5Z5R9dcCaQmFJHT7Q0GhWcQ3212/S+sww=
X-Gm-Gg: ASbGncuU0k4klCgiR+gjVj8mvNwSqttDCDgesnDr76XWLgvLRojiUiAR/meTY1Yik2x
	BzuzT0vkkKdQ9i6LizAPyNnJH0I60ixU9dwfKtExXANp3HyaH7XvZFraShMKPcDP7CsM1HkQdBE
	dZeU/CZ/i2UPq3rg2F/mAVI2D5cToxt1djDoPBpR+r+7oSqZOjqudo9NzF3a8FhhnZ/hA0oDPm8
	mOqMGkZizZCzsXXwxa47lSRA4SfMTLWPvwWlZI8f/BO9JOgdcezA404AZdoULNsI2lve6c+00+V
	ccMAdarlGdpZtMI42hd3IbVhy3rXP8CiBHXn9+jr0nsq+Kpa4gyC3SHezn34AiCaLFXfddwnSgZ
	tVQ3nDJZGZ5RIg7pHQvU/ahj3cF9dQQWG9gB1ZbI0dvE8ED36dVfnqJFVUgdyJ+Q=
X-Google-Smtp-Source: AGHT+IFYhc3CtD4A4MOtCvaPnngWumd1dv65EYgG6Om/yx8+SjrSSPGMr9gXNjJ44lHxB3thNgEtIw==
X-Received: by 2002:a05:600c:1d09:b0:453:1058:f8aa with SMTP id 5b1f17b1804b1-454ec15a834mr85731655e9.15.1752400126413;
        Sun, 13 Jul 2025 02:48:46 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e2cfsm9234034f8f.75.2025.07.13.02.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 02:48:45 -0700 (PDT)
Message-ID: <63e538bf-16ac-4f57-9578-2ae855f5727f@linaro.org>
Date: Sun, 13 Jul 2025 10:48:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/15] dt-bindings: media: qcom,x1e80100-camss: Convert
 from inline PHY definitions to PHY handles
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
References: <20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-0-0bc5da82f526@linaro.org>
 <20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-2-0bc5da82f526@linaro.org>
 <3376b0fb-f3c6-464a-9c35-30a3f589b856@linaro.org>
 <eac19ad2-78dc-44e9-bc02-517272ba737d@linaro.org>
 <3506d911-da9f-4639-9c83-aee0a637e9b4@linaro.org>
 <352421e6-f151-435b-8dce-6c02a6d0e747@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <352421e6-f151-435b-8dce-6c02a6d0e747@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/07/2025 10:39, Krzysztof Kozlowski wrote:
> Lack of in-kernel DTS is a good argument in your case, but you must
> mention ALL OTHER USERS:
> 1. All drivers in Linux
> 2. All other upstream projects, BSD, U-boot, everywhere upstream
> 3. ... all possible other users of the ABI, so out of tree DTS and out
> of tree kernel folks. This one is close to impossible to prove...
> Luckily we assume this point does not apply here at all. No one out of
> upstream trees uses these new bindings.

OK, if I get your meaning here.

More comprehensive commit logs and cover letter - including doing to the 
work to look into BSD and u-boot to make sure the change doesn't break 
things for them, which I'm nearly 100% sure is the case, is what you 
need here ?

I'm fairly sure the only real dependencies here are people following my 
development branch for the x1e laptops, who want to drop those patches 
and receive upstream stuff from -next/-stable.

---
bod

