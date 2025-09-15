Return-Path: <linux-kernel+bounces-816283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4150FB571D8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB92C16BB59
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFE94502A;
	Mon, 15 Sep 2025 07:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V8n6zf7B"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEDC20126A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757922388; cv=none; b=VcBtNXm5OgZcF77TEsLNB2Z4t3/tjqb+TGCKZLUfTW6MQoLzU//IMFpR1TEIBjrq+s9Vr9iwrEyGuXtHygD6wrk/4pfqn2nAIMXrSQPPeqh7+lPmF/sUEh+G0RST46ikd0okQYuALcrJuIpEvN/yYyWvLeGmKH0L2ogQFY9NHj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757922388; c=relaxed/simple;
	bh=rxgBGv2zMZRxz4TM397vl50YX+5rV/wH6l1JB5uVKT4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cdX7WAx31XlINhdO5F9wW6p7EJR96SfnnS1Hgmpz/5cPNnv5ePlAjMJanqVqgmFYWHPuzno5d3t422x7nM7+mqiUt4OMzTAmdULUt60ZXi9qnUsS0sE6mQ3BHOfgPqmqn0R/ay/UVbneONE3OFJIrDP5uy6Hj3cySC0+bJAUkng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V8n6zf7B; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3df726ecff3so2069208f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757922385; x=1758527185; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rxgBGv2zMZRxz4TM397vl50YX+5rV/wH6l1JB5uVKT4=;
        b=V8n6zf7B2GCu6e2opOUBFBhGIpz5wG0nHLqtXHW2OD3gyMT+lEotEp5gupeb4Z5Wfr
         gNojRbFUEzisxILvPenML4ZLC6QiuoSS1wjKzUd2ob85vpmuTmNmqlKhbOjrhnLZRl7I
         9zSYiqXxh0X/r1kKhByZR4eLWGFP5XvWPbHn36MXcrftKeOTeSutuLTRk3Hw8FMOA840
         gfiImqfIzJNeZJe4dGP7dZc6NpnCjRl5KiFoWq6hQSjqU8+n8xCoXPd1iMk9Fo0MCYHh
         U6FqY6h7jPfRFV5sPasorwF6FL8mdB9hLYBeisVBWo6zA+0GJw12GohQKBTipHZSj9JJ
         kBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757922385; x=1758527185;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rxgBGv2zMZRxz4TM397vl50YX+5rV/wH6l1JB5uVKT4=;
        b=sqmHEk7K8ebQH0ANHqH+b5vJByyEWoNC7XrAyiyqvHgNp5ylZSU+y39nal6aycLLsZ
         OC/WnC/cvXBQbfYIA9FO0JGPX42rMAldTTPB9ZNaBqj7Z/u4P4U5N7k8D3vPNL9tXwbB
         1ohUa02anD4af13wbaXWkSDYJj5BliutRTFza1PtF4EGU2BscjUpXRUPrbVOsx2/zAVb
         pV4DljJ8UG3Xj260mg/6BZbgXDktLOs35fcu5PRShwdSyi/LCMEIORQbP0h0mZwP7cun
         Z5c8BcELXsizLW7rUlSqM4baIpAZIV1GOD8VVS+2fMyhr9KJLH0Wgfw84xgXZon/73zO
         UAEw==
X-Forwarded-Encrypted: i=1; AJvYcCU0EG8ZjU+ULy4RHW5boMhKNT1HQYQZw+pF7nGlKW8NtjuiwvFfmh0nJ0f3X+jImqGKce9OWN8awh6Dwcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUkRpwQQmkmsbVJbJUjBUKmhTs4s6VIhPLK7lLGTER69E23q85
	QxKaKR7E9lBLm6Stpajewl6ct5/39/Kt5xLAWvfheL1M2+JujjuzEjpdX5plxh42Rvo=
X-Gm-Gg: ASbGnctlPpxqxU61TnvN4uZ5aU+2Lw58A3npnWQ/UGCnjLRgS9X/8+wmEYYpm08Mnsm
	9HePtG290y0Dr3QoMHFOch0euv4Hqi/7lfqTptThNzJhztOZHWP8XNtpQtm/e7/loSAwL5/dGWp
	O8fbQH/Vf1x2g3JEET2+HmR7hvdXsaOQ/ZoDqCdpP2Wk5SeEcADIv+bUh+l17IRlfp9dR1lTZsS
	jllCI38pQJNyqvL0VfRhCU+xdF2tKmYuBTWJAdpYrTR69uuxR2gasxh+r2mVGVTJVqMt1KTU0L4
	zp5SbjBk4k3Wse7JOCqYdq1LNNe6ycJzBpvpqkpuzyjeQk4XUec07HkneLgHv+xKUtTJpXSwz/n
	udhIPfJJC8BMV9VY+R3/1+OhUXw==
X-Google-Smtp-Source: AGHT+IHyyuLf6J5x2h8+77IB2PsvJAJV4Tes0P0hl/pG4jVOFAqE/MRdKs5G4GFgkNVlw9YzjUjKhg==
X-Received: by 2002:a05:6000:26cc:b0:3e7:458e:f69 with SMTP id ffacd0b85a97d-3e765a08312mr11049943f8f.56.1757922385224;
        Mon, 15 Sep 2025 00:46:25 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e9c2954b10sm5452113f8f.50.2025.09.15.00.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 00:46:24 -0700 (PDT)
Message-ID: <62d7c5221b9598f390102f4db8db483af9f34289.camel@linaro.org>
Subject: Re: [PATCH v1 5/7] clk: s2mps11: add the support for S2MPS16 PMIC
 clock
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, Krzysztof Kozlowski	
 <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo
 Choi	 <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>
Cc: linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 15 Sep 2025 08:46:22 +0100
In-Reply-To: <20250914124227.2619925-6-ivo.ivanov.ivanov1@gmail.com>
References: <20250914124227.2619925-1-ivo.ivanov.ivanov1@gmail.com>
	 <20250914124227.2619925-6-ivo.ivanov.ivanov1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+build2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-09-14 at 15:42 +0300, Ivaylo Ivanov wrote:
> Add the support for S2MPS16 PMIC clock, which is functionally the same
> as the currently supported ones, with the exception of a different
> register.
>=20
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

