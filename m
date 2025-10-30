Return-Path: <linux-kernel+bounces-879153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 147DEC22667
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC4A188BC41
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0A62EBBB3;
	Thu, 30 Oct 2025 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="or7uHJAn"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EB0248891
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761859020; cv=none; b=Q70Srxxvzvf2NKFsjjryOZAhJu/Mhqxpha+gcVYmgHjk0bOqIx6f6XU++GeT5wIFI2ol9/B0xCU6xWxi9mfnWwPTNYa8EUBlJW5/SC6cvz0iyF4w5bMSkrQKrOHh4OABR/HgT0H/O82XvSMQFi1JxQ7aVkTuwafKzRldvJWu8Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761859020; c=relaxed/simple;
	bh=z6375WTq4Yvi4ovxduQFOHZwxvwgNlfEn5b74zi9Rbg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=ansq7RC2z4wuh1JEaGoUzh4ezMSY9nSjwG0KP87oZKzQsEaPHgkK7tSNjWT4aDIFutX40liYbbCHaj5Tqalmn7KXt3plH3gX6d6UHZaZ/6Gu27KU9258REO+C4+T8WNie8mvxvulrSQ4U9FwqcH695kZEYDOi4FmrnSV3dx0C8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=or7uHJAn; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42421b1514fso980402f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761859016; x=1762463816; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6375WTq4Yvi4ovxduQFOHZwxvwgNlfEn5b74zi9Rbg=;
        b=or7uHJAne3M168VW5hkOAZiNpBMKOY/XL62YNrIOzzKli99+ZiKYNPGbBTTqHhJAcC
         h8BaAR/XjfhU0KG8oOpSV2rWvK5zON3ddOhOUG94cz6m7Nsivhma0lfflIr4zWBf9OMC
         LkmZa7csBbFQxKFaqTU+y4pz0Q/K44e4M1YycNmryoUWcT8RPV8mhIBw6E6LZz3Nklz1
         e/H1DL38CV1fDfXkd5Se7aElLvaxurMsqbRvB3KRDXdz8ibIlVDeOQQ0YCF2hZE6MUTR
         7ZO95od0DmaVP9INcPeH1fagbYP03duxKLGtFPFtpzWE4k2LsnztzQ891E7KyX/y+n82
         AgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761859016; x=1762463816;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z6375WTq4Yvi4ovxduQFOHZwxvwgNlfEn5b74zi9Rbg=;
        b=plTO0pxMDeDP6VuK5mavwuWBFXPcPKB0+SEWu9YzLlxZBpyNdl4pWqejM91hBL+kF1
         OOfgrw8eno5lQYG8oDas2xTYTk9PeLGqnY/rEP6nq1P0OOgprz9IuEiSIpQh4UJ6x/2I
         KYX56cD2qz8s3VYbNgNEbciGcvL/qXlJYBgYdpuhYRHCuYUHzdYtEXSGCSEJtIyKTfRS
         zguqu3SS7Ky5ZM35KNeyVZwcnSapCkuR2WL5VsgWSk0Hck8FOX15er0u1hJB8mBFx0s5
         ecMOSnVYDavarraQdab4d1PQEp5EXwrW+DKqF71IxXEzDF7IWZBBk1kn/LqZh0ZaFsD3
         kSoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgfbyitLpMEJzT6NDvqZjo1WG1lcQg2o52fUy3Pn5Q+CESJ/xHQ4SNrC6GS0Bbhhm/ldxLMHVyCrDxIRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFUoMTNkmq2RYO8CpRmyyj+o0zhQ8PScvjQIjDepmQgEyxsqfO
	MojfHi7DWXpaFHmQv42e9TKlT3PxELMb48O8TLRX0gYBmH97Dmia84MW7g2skGR9uMY=
X-Gm-Gg: ASbGncvXV9q8C5bZX5CP9dC80x0Odu6jvwU87mM0OgiVQh00yEH6wVRfwKt8zCBt1T1
	l/woPRYsI4W5MNKjzwEiLsN45hshqa3rLh88xFM9JQoZQ6YAs2kZVga9iBlZGBtHr+eN3ZH0DrO
	TUs4eE01hMWkPW+F+Jsu2JhawcInVr89XdlYBin9SW20OdlfQXE1/j0a4YTftguzvZ7eMpM5NVL
	TGMkHqh9e7eK3H4KpZMTCCxJyAxxuiNneGuJqo4zT1xpwDkKbnZOlF/1mlbVqOYJ3KryoUFzCIR
	2uZW2s5Q+BJgDM9k3aHHzIufbQXF+Pzm8zBaDdWlYVabqLlAD6Bp6wvQloTFftVUK3gBcK68ntr
	4kJhLRzqFcolu+OcMuYixZMCoeH5LmMruz3o2ujTuik03xBGLjGe0FCJg7N0cdPc53ir6Dch1kZ
	PvTexX+Xu3W92lwE5oA0BFcJLUJA==
X-Google-Smtp-Source: AGHT+IER+NlrHMyAE87dwI1tkEn0iN9IkW6YNIezVtY3mnKy8AByh4iQATc1QapWcTKE5yrO18mcDQ==
X-Received: by 2002:a5d:588e:0:b0:428:5674:7a13 with SMTP id ffacd0b85a97d-429bd6adccamr865686f8f.36.1761859016075;
        Thu, 30 Oct 2025 14:16:56 -0700 (PDT)
Received: from localhost (054722ac.skybroadband.com. [5.71.34.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429bf19c53csm626241f8f.34.2025.10.30.14.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 14:16:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Oct 2025 21:16:54 +0000
Message-Id: <DDVYW9DO3Y24.36V1557ZYB2XI@linaro.org>
Subject: Re: [PATCH 1/3] arm64: dts: qcom: rename qcm2290 to agatti
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <cros-qcom-dts-watchers@chromium.org>
Cc: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20251030-rename-dts-2-v1-0-80c0b81c4d77@oss.qualcomm.com>
 <20251030-rename-dts-2-v1-1-80c0b81c4d77@oss.qualcomm.com>
In-Reply-To: <20251030-rename-dts-2-v1-1-80c0b81c4d77@oss.qualcomm.com>

On Thu Oct 30, 2025 at 6:20 PM GMT, Dmitry Baryshkov wrote:
> QCM2290 and QRB2210 are two names for the same die, collectively known
> as 'agatti'. Follow the example of other platforms and rename QCM2290 to
> agatti.dtsi.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Alexey Klimov <alexey.klimov@linaro.org>


Thanks,
Alexey

