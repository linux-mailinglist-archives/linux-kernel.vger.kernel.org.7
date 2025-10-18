Return-Path: <linux-kernel+bounces-859020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC48BEC7E3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 06:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40DFC4E4A6F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 04:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8856326738D;
	Sat, 18 Oct 2025 04:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aW3+E4dH"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A926FBF
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 04:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760763319; cv=none; b=svLU4SyLa6hAOAANsQr9NDfjtRokkeVnWRRMf0BNzARF0sdZq9kyD14+JNbWJhwIK9XhvqXCq7n8/gq49zH5XQGAoGc08PFgThphnznzqT8mYIkP/X5jGGY+lJzzWKI1m9jCp+h5VvYH8F0vIGS5C8EkMsq3mc36AyoOfN4u7H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760763319; c=relaxed/simple;
	bh=ylW2XE//NO5FaS2GRo3y6bDQ5bXrKLQ1fYi38QPF9Mg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GzX/wgT3TlrpSf0MzVOX8aJJWtVGCNN4If2iFUxpN0/HIq4Eh3hVwOOIWxgvERAzRQrqBxoyRn5EMFmEFkB7MTXGr/YDA6OAmNtjHxL4h3Xc/YvAK123LKRUXLA9lczOZz3HJCndyAwWYeKi3/2ESOYfHTbtvQvgJADEzMduj50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aW3+E4dH; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-426fd62bfeaso1136934f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 21:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760763316; x=1761368116; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lev9x6dFfmdCM6nU9lvB+aId3gAOWip6By2m8dIzqR0=;
        b=aW3+E4dHSrakor4dnozLsjQIlv8RN/iSsLbT3RO9FZxm/6x8ysPes4d74J9PQ0bQX0
         0D1Ntro1d7gW9B69OndpZw0CwIIG6xm+xNVWKWPpVMgirzCGTtBZf5Y7V0vbMcp5iS/C
         93Iy7KOOrg9g4nEjFnKyY/M59KXTlee0CaVwYUPhERI0o/e53pnu7wvRVoHLd74bi6pW
         J1EggmDni+0Ws3Igh9uniwfjuomlsUs/g76O4uJgBnx66AdtTt3v+6v5+hJAul+8q6LD
         Jbns83QWDNe4Ay8YrQDyDuj2qYMbPGYSsfiz9VnebaeGptMzFyMaylCFGnK8C/prL84u
         gIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760763316; x=1761368116;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lev9x6dFfmdCM6nU9lvB+aId3gAOWip6By2m8dIzqR0=;
        b=DQrXa2rdbONmXnm3vVLIIF2xRgzdd8grQvgvylmawqgBpzp6lMZWQb1F8km9hf2zLP
         tNFgg1ypum+yOZH90FcaafuhO5RA44c2b2z8oMft7EL7o+GThq+Sogc+Ljexe+CPmnb1
         WiovquHW41m4ojPx7MB63eyWXInZ7rOjclpp7vpQJ3+sGrEcq5yn3WR7Jzy6LTt9LDEU
         gw47JdtKdw8RQIuwwo6oJ56M5DyWJV9qNtPXygQrkmzx2cjIiS+bXA/KHIeJSrWg/mm3
         ju+x895HcQ9FxellvEyQoUdXaTKOiH3wHfodVDkcZrY/oADmpps3tnCVXLHP/9ly6ucT
         VhJg==
X-Forwarded-Encrypted: i=1; AJvYcCX8QAZw7BtU70ubNt0Y70K8KurymOtmbnJ12kBQCDPT8gvAGgeAMmEvEMnvI+F1zyDz1Q22uSTkzK8yFjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDDMztJSEFhZmuYbXRQm2qqjeMYhmi38ZMG653P5UiY53iileg
	nckBHhXOgtgjoApN9Hn8zysuGKPIWbYNVKnpOd3rWbus1L3ziJcc+4qtdHDLdHG56qAYVVcNbEU
	2EtQ6
X-Gm-Gg: ASbGncvET0AgTCiZj4CopWD4hDSZ5Qvnj0YUsZL8ie5crDU56U4OiD3f/iOxkAEwBk1
	PV7xK9hbWKceTyLhDsN5IiMGIzqxg41rihQI8v7EwUxrK00xuQrDujZras9EyeuHh8RJhzRmd5M
	2IsPyy0xHCtVtwyQXaUwH+3Ao7CMDB9kG8+Vgsm1QVSUlnebiG5m8QH2UqjZRCG3npfdP5WJ3gC
	enyOc/H8hdtqPe6U4z6zQkTInu+NS46K5UZzDWdKdXNr1nPXhwq7b6ZePOWLix0HXlm6aHKWisE
	qXUxRAQF2iMvrfDg4H04rkuf9ttzuKBGNzoxLI0JhTV+yMHsERsjqaNHCvE7L1y1vRfWiw9il16
	irE0G4zInBX0pJ6+eGD0rBkOsbzeaIwmq0xd/dBrUNbMPHTKYGAftRTNjPcWmWpH+VJqIsbNkBx
	DPLHQ7VeSMXIihQg==
X-Google-Smtp-Source: AGHT+IGQ2PwsTgBVhX4BIKplCiN6Fm8dEPVQVzbBaqOMGQ2re1g52F54o1ZfdXxv+FuOtuW57XJ50A==
X-Received: by 2002:a05:6000:188e:b0:428:3c66:a022 with SMTP id ffacd0b85a97d-4283c66a3a1mr577628f8f.40.1760763316335;
        Fri, 17 Oct 2025 21:55:16 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:a618:4d7b:922:a98f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a993sm2706026f8f.24.2025.10.17.21.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 21:55:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 Oct 2025 05:55:14 +0100
Message-Id: <DDL6I3XL46VX.XHDZ5GTAJK09@linaro.org>
Cc: <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
 <srini@kernel.org>, <linux-sound@vger.kernel.org>, <m.facchin@arduino.cc>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 0/9] ASoC: qcom: q6dsp: fixes and updates
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Srinivas Kandagatla" <srinivas.kandagatla@oss.qualcomm.com>,
 <broonie@kernel.org>
X-Mailer: aerc 0.20.0
References: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>

On Wed Oct 15, 2025 at 2:17 PM BST, Srinivas Kandagatla wrote:
> This patchset has 4 fixes and some enhancements to the Elite DSP driver
> support.
> Fixes includes=20
> 	- setting correct flags for expected behaviour of appl_ptr
> 	- fix closing of copp instances
> 	- fix buffer alignment.
> 	- fix state checks before closing asm stream
> Enhancements include:
> 	- adding q6asm_get_hw_pointer and ack callback support
>
> There is another set of updates comming soon, which will add support
> for early memory mapping and few more modules support in audioreach.
>
> Srinivas Kandagatla (9):
>   ASoC: qcom: q6apm-dai: set flags to reflect correct operation of
>     appl_ptr
>   ASoC: qcom: q6adm: the the copp device only during last instance
>   ASoC: qcom: qdsp6: q6asm-dai: set 10 ms period and buffer alignment.
>   ASoC: qcom: q6asm-dai: perform correct state check before closing
>   ASoC: qcom: q6asm: handle the responses after closing
>   ASoC: qcom: q6asm-dai: schedule all available frames to avoid dsp
>     under-runs
>   ASoC: qcom: q6asm: add q6asm_get_hw_pointer
>   ASoC: qcom: q6asm-dai: use q6asm_get_hw_pointer
>   ASoC: qcom: q6asm: set runtime correctly for each stream

I am currently testing this series, so far looks good but
I'd like to test it on one more different board.
I'll also have few minor comments later.

Thanks,
Alexey

