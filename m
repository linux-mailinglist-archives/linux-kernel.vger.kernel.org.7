Return-Path: <linux-kernel+bounces-877169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5EDC1D5E3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF7304E5501
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F194231A81C;
	Wed, 29 Oct 2025 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fhvsOc/Q"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8303195E7
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771944; cv=none; b=GaIBQY0edJy/qnwKWwZFQNzcVe/RSQk3X1TVsh1EsVFvlMIZfokko9VAOFly0BcFZxw5yxnbcFwr0AVfL19+LSqzJQt8sqZNGL5xx4Yb7Vwsp1sUgHpgIG+nw7H9crfll+u8fsRVW4r27xMLzZkMEof4GCPeAWRSIJ/IIYJR+Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771944; c=relaxed/simple;
	bh=rX966CQi+9UiDqKNCwMzzhyOwPxSPJPXDazMdIto3KU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ItTrRLHYM0SQUKm10ugfLPp/Nh4s2JJY3Mc/0xOzX1osKhgHko5+1ohHE6T//50Ub8Lw3MaYVIikU56ukVNpEsw0bJzKyO7yfFbBoLVBMOaQ76UpvhTv0AOE4Bp8jWQk7RPv/hF9cal0LScnOP2Vuo5hcEQPbYAcD6C7oJe6GO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fhvsOc/Q; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so163507f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761771941; x=1762376741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpxzYKWAnbzgsLyXnbb5p5d3wlWt84Zm/jE0R6RMIWA=;
        b=fhvsOc/QcDAbAORS2XKkYYbYCG+h2BcKBm0aeExVaRYrL/lCKV9GCGOUPFKZ/fa3Er
         nRzunkh/mr9A81yP61tGpW2d/UYyduAh3FbTa2MAVbUio9XrcDinLKmOBZOUNgWKxOaw
         t2fgYP9dN0vLSIl5LkoMV0H197/VAH4zuy8jBqTH+Rwq8Zy2n45JL1pnXgybbwgcdszJ
         hyIpxuuItOJae22R8WaA4bEjDkLC127OhzefdjW6r+jPmoeraB0tIZExG3wLIKK/KThH
         znnEDlMVlL3go1iBsMyKrtFI9ZBpsXPVcZErmWQ6u9zEk2k8Dj9tvceEMaRN0bqUOCtS
         8bbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761771941; x=1762376741;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpxzYKWAnbzgsLyXnbb5p5d3wlWt84Zm/jE0R6RMIWA=;
        b=eYV0bCc/V2KDgq8kGAOoxgkiISrGWH8SwMqKjbEGAVZ4mNrG+tUdwxZ6q4CtuWied3
         dixByAh28N8vDCdG+8t3I03Gb+AODm+dlxs3lQmezo35aOUQZMqkEk1ur6ML5mA3A1Xh
         lzPh256Eqzso0XwHyGXIDpK75pUMo3nnJfRGLxsTbyWoZESmnzv9BgGxXGLlNyHu8Mpo
         KMhNN6oVa7lO7f8dnWWoT7R+GXlCuZ3YufEaMYTPFpTs9Tth9qSRta/IkHy3oABp1fk6
         TcXjaokYtH7M3EkixHKzs2vLs0APCJ/dvX4ZUxFIAYt3Y/cJz95qWP1Eqk17EusynTTB
         9Ogg==
X-Forwarded-Encrypted: i=1; AJvYcCV/LPYjzJbzqCoqAXhSbgPZTSWp/e/B38/sSBHvY7ti6tMCar29Nckf61ilDJnmj6MTAvv780B1jdYF82A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX4O4D/n9aheRWWnz2X1AQxh5diannpcZ3wEgY0BOfD9q7c1NX
	YeRmk+zUdISvnotNupzgxsB6UHzw2MMdxxhpklJOP3sJSd/OfDJmvODlKGKNPS03GY4=
X-Gm-Gg: ASbGnctr8Orwn5OgWs0VLmJn8jGW9BiWAq4ht9kxACPifuNdV0m1pmgX/XIhQT1odVe
	KxtWvBWUpTLJY/t6d4nSaJknEi9H0njqAPjL+dQ6gqFcxSe7YyrCOnluloqoPYRaglWW+Q6lNYu
	TOwjMYVmrc/oqN+cJKk6eWBL5WYUlqNCz8jHphIVe91sw1LEHIv/OzXT5mcqOPMtfp1LRLBwS+0
	3FpzLCOGZTe1j06RalJVP0/AbY75R2WQZNPrcqOtLyyXIBcIlX9vACiYuReT7B3K9m5JWyywkiG
	zOQ5ZCJAOxWa/ZXxi5pfxDYMF5/38y2pbwsnuZH+NOII8X9x7x3Vpavjlq/ZAVIcIIFdG9BnaAY
	n0GoHZYgHI6ufmZovChJMGgX5ac5cHyJXq3Cnx3POckPPRyzEXvZUo5JfNANw9Cp2V5klh5xGOJ
	fFJmMDrH/ljiCZZ0UjiGYT
X-Google-Smtp-Source: AGHT+IFjNDVfG9nSVNxP5ccXtI2gzlalGw+f6JndpkQvQxKW+TdZft3QWHVbSd6609LOnuWGywP0fg==
X-Received: by 2002:a05:6000:2506:b0:427:55e:9aa2 with SMTP id ffacd0b85a97d-429aef78924mr2715742f8f.9.1761771940865;
        Wed, 29 Oct 2025 14:05:40 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de971sm27815109f8f.39.2025.10.29.14.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 14:05:40 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20251009-panel-synaptics-tddi-v5-0-59390997644e@disroot.org>
References: <20251009-panel-synaptics-tddi-v5-0-59390997644e@disroot.org>
Subject: Re: [PATCH RESEND v5 0/2] Support for Synaptics TDDI series panels
Message-Id: <176177193995.2073083.3709590896561728636.b4-ty@linaro.org>
Date: Wed, 29 Oct 2025 22:05:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

Hi,

On Thu, 09 Oct 2025 21:52:09 +0530, Kaustabh Chakraborty wrote:
> Synaptics' Touch and Display Driver Integration (TDDI) technology [1]
> employs a single chip for both touchscreen and display capabilities.
> Such designs reportedly help reducing costs and power consumption.
> 
> Although the touchscreens, which are powered by Synaptics'
> Register-Mapped Interface 4 (RMI4) touch protocol via I2C or SPI have
> driver support in the kernel, the MIPI DSI display panels don't.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: panel: document Synaptics TDDI panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/5c42579b0705ea372ed7e6f158c880618850b409
[2/2] drm: panel: add support for Synaptics TDDI series DSI panels
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/3eae82503f4fb24e36fc06f6827b8360678c2555

-- 
Neil


