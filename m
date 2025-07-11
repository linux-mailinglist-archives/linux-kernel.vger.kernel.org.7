Return-Path: <linux-kernel+bounces-727113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A36B01535
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919CC583CFF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269A11F4C92;
	Fri, 11 Jul 2025 07:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="pRS+m+lz"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EAD78C91
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752220339; cv=none; b=KB/GPShuY3GYpD4LnIhYsodXC9ERNdlMJoNx6jpVFS6KZEDdKrwiLT+CrUvVDMgxknD7tpL5buv9XasjBkM78t3/oDaTcw1Bqwjxh3tU59LWuU+BFNaMvrbR5N0DjiArarfrcVScVAI2WHa+Xmy4ZK9T347YMo+zZNpEjQ1A5KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752220339; c=relaxed/simple;
	bh=xDu1IZi1PzBpLxza0uHTENLwHCwBlGpxlSAJZg1vPeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QH7RvnPyB1r3whDbCcy/lBfJ4ACf4JmQNZroG3GPqqIYX8A5BrRX5j77whSPugLXzzgh3XsN6nZZ6kVVt9Tulgil6b9nKmSgigN5GD0tuOsNruN9H7sbmfJbagvh2kglNyBpEmxpl+yZbfFyp2DhD372r3pP+lV/z5M8SGVWbjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=pRS+m+lz; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-558fa0b2c99so1479167e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 00:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752220335; x=1752825135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDu1IZi1PzBpLxza0uHTENLwHCwBlGpxlSAJZg1vPeY=;
        b=pRS+m+lz1XXwhkC2sb+1iRSJtGIA0MSXHi4eEeSEI0U4Kz9IXPuGhHWhW2koGQc2fF
         i0LDdSx7IibeIsJNjwB8jgKawJwqQ2IHp+f9xw5/hWP4Ry/8UeQVa5k44enHQaqGksUE
         q5ucEk6admC9zsDsdfsdbtTNavIqtX2LzxB+a6VCtqCKQcoV9qSUUm2QmOqiy1NzlSvN
         vU+dsKQ87dHDeO0Q8C/LUaDr7l7zFJDLJN1gD172/ZGcW0dkdXurJTq33A2BhjFzw+ER
         Rp7jUnOSDG0sPAIX+JQ02PKwVvIuJcx4Dsl4m2NaOf25uZd9aGqhaPzAc/oVRDBDCluX
         jqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752220335; x=1752825135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDu1IZi1PzBpLxza0uHTENLwHCwBlGpxlSAJZg1vPeY=;
        b=o2A+XC9R7XMtxnEUUTpusatyVa0c26SX0NOilklJ8UX8oskjug2gfCcPxCp+76iHgM
         yT70V+CXc4Mlg7qP5hhC1JtkOwfdlWoL1Ua1mnHf/7RHcFD+QE0Wcap/ZCfkDJ0yJob3
         xpyA9kDYBMI6y10iqDpT4NMMCImbyBZLnugzGpaBzRxBZLTID7sXi/Xgn7oDu6nIC8l9
         hidGB2IErC6TycpM/8W3GEBVQclYhUWfWQgPi4OOzv33mO8UP+bvuFO8Wr6+ki6uqgc1
         XMS88D13zo50VqBH2D8iqZY2Iv7Yk40GTzQPZEhc6iVoTV6ileRNisXI6/mDOnt1axYW
         OMRg==
X-Forwarded-Encrypted: i=1; AJvYcCVWCGiyan9GVolVOKs9piToi2DfR7oH7nZHn9tKJdYR5V9Y9C/mC0okeH+XQt/UR9iNxowSZRaiprEAksk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiSt31M7hxi79g1qnV7XYLs+L6k3rk52I90tcOjlt54pWicQxw
	+hRF3sRLUPWsynYZg69LcdMT2LdMKxR3UPmDHy70+nGAVGhlz3z0KSpVsLyqR8Nij43SO+c4rmp
	5kMtbs4O75WXf3l50FfMCP7UCY+pbyu6EF8BZDbS5Yg==
X-Gm-Gg: ASbGncsQHjTsbqQcHII5ZufbgBuxBmdlHuVrAp1xqAVuJLaZ+g/y0EKctVDUmwXEjzO
	7tIr02ElL2aSKN8z+GBGpJyUBTxf+jDKEUh/J21WiWklycCO8n/pOuGdQkvBEwCtcb/0RBJr8XR
	eC+dMkLtll4aI3lbOMynZHUQStiB7lCekXjUCBtO00ajAuE2zv31GEaLpDiD5YlAc3jgorFAa9X
	8TY6ktKCphWzd2gzO+YqBrzoLdy8hZPT7R+hw==
X-Google-Smtp-Source: AGHT+IH60ogAfWfbJH3MFwcCvSxOgE0SFBGta4jItgpzjkt70aoyDG8O9/ooBirBJu6L+sORksZUc1FbM71/UwsNZhI=
X-Received: by 2002:a05:6512:3b86:b0:553:2868:635c with SMTP id
 2adb3069b0e04-55a058c3d08mr446259e87.48.1752220335245; Fri, 11 Jul 2025
 00:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630-qcom-scm-race-v2-0-fa3851c98611@linaro.org>
In-Reply-To: <20250630-qcom-scm-race-v2-0-fa3851c98611@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 11 Jul 2025 09:52:04 +0200
X-Gm-Features: Ac12FXxQS_ND9R3kc1-JnsO_0EIP7wD7vwZ2iNngV6aFbY7iD-1PGe6GfTZujA0
Message-ID: <CAMRc=MepAV4iHvGbBKmrq1NevC9OBZ1z=JBP-AQWhJzZusK02w@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] firmware: qcom: scm: fix potential race condition
 with tzmem
To: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Johan Hovold <johan@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Johan Hovold <johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 2:12=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> There's a race condition between the SCM call API consumers and the TZMem
> initialization in the SCM firmware driver. The internal __scm pointer is
> assigned - marking SCM as ready for accepting calls - before the tzmem
> memory pool is fully initialized. While the race is unlikely to be hit
> thanks to the SCM driver being initialized early, it still must be
> addressed.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

We're late into rc5 so gentle ping, any chance we could get this
queued for v6.17?

Bartosz

