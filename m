Return-Path: <linux-kernel+bounces-859780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EA3BEE8E2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 17:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8F4401A07
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 15:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1CD2EBB99;
	Sun, 19 Oct 2025 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nnqxyGK8"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE7D7082D
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760888580; cv=none; b=A8IdyUj8Fy1XaI9x4HXsvA/lisTLRTj3LsegtZBKbQQRJRNK53cXXAr3YACEzQ0thZixzlO21DulDf1EEQA9OIDNXiC11EpwINbL01NrWg0xZ6wtQ6Xiee1OUPSWyKXJfxvb4cXouZkf/KX7gwvwPdeq3be3iLNEs5xYU90fIvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760888580; c=relaxed/simple;
	bh=6yMIQ9DguSJe6ic+F9Z3HJRxEhmXjyWbpn76vKv2rco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haa+OXJz120ToEyV5cJBpYNz2e2m3r1ig6ypcyDIXE/g+GenShnwlP8YiWIpZu7e0KpXMPUwG0NDqW+cefaRM8/zvQVHzwkArq1b/5H+igZUVo0srH3/IQIVYB3MH9Tr1y8+MJbEJAA3VGrn0QL9qVVm2ZArcmDWwVghDOFt5YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nnqxyGK8; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso3496789f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 08:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760888577; x=1761493377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kfxazAlKuk9K4Vi4FslEUzQq3LUxlBfoLS51oq9+lJs=;
        b=nnqxyGK84PItv9NaV5gzOSwYKQS591BBIxrrDkEQBWmsn7L+MbEFfCYO8l5zqXBrp4
         JeUEKv7itnsr4SCxRu/rodUgAnRdJRpjuxlKu/36o+a2pmWd3xOunz0whKc/9lziji6l
         G3kqhNLWNSqhGmmSCk7GUzm8UwZ6atQWdKtbZ8CovXQU6BzQkqhN9BOONETOkD8SocYY
         kTtHq6+wc/bgsUq78dZA8eEUmtUKcSS2tpsOAPG0LVbS5SJkZhreYHLbOiE/jCtIaj3s
         6IlMhLaFj5S3cEmHssf6M1XIUidb43wVtyMeayUNLEzr1sfM6AuBE21Qk4JAA8KZ5E0Y
         d0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760888577; x=1761493377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfxazAlKuk9K4Vi4FslEUzQq3LUxlBfoLS51oq9+lJs=;
        b=WHfg4DmgV1RWxJ+xq7wcxUTkFyil8eoZa0U4q63qljcGqTbwjgs0koLbDrJRhIpMF5
         j2ykuXXJkh71aAKhGGyPiuLkTAF+/PIh77S+2HKB54pJiG1Anls7i8KbxtDhPj8Dlw+K
         W4wofD3I2XCcrZK/OeOp1TmLUZzVaQtQKzFSUrl+wvHI/+cT90j4Twdleotg6GrpcdnH
         x8uoiYrNyBXcYK4FfzMlRYXj3vEbm+FUzCCou73LnfvjnmlQPuu72zloSxS4EMW38FnO
         6h1KNA9Y7KgFlNmtS0hQOUDJdWQKxQEX6ZZL+2Va/L/vo4BZVPGXEmgW2rAWVLJOtvKp
         T1FA==
X-Forwarded-Encrypted: i=1; AJvYcCXK0+hsbC/CzZr14ZUe23Cw5LStHOs0J7sz1hj/qyqSGy7oz9oIJje0qJBbFdwn0TuBbK/sX8nMcKJs9uE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9wB+eRH1KddOT71AeSqXUR0koQJ5QGv+9OeKM2rYh7z/ul+Ep
	ncbJEXoeGjZ2fMH8lgmvW4M+FvFFEXLYwEUrFblaIfTXZxxCvTGgIPyHiKPnzlHp2Io2Pai8iS9
	ohCxL
X-Gm-Gg: ASbGncsej+zCMPokbZYy8pJiArHbjVbaSHLoJjvufMXZG0tjJ3+jjjIAgutp+4K+40F
	eQI+AJITmyxU2SKyQBCHKp3sH0z21buV8xQjlwVMMWx0VPkuId2F7si5RLpiNpA66SU1X8tL2Iq
	mwzQF9kEpiHlup2I3AH43MGNgqf7x3jUa8rS5GRQkDZciqsGSFxBMCkB4fX8Ev30ZWtK/6aAmps
	U8JHBmAaCR9BJxNbfuGLF43TEZtp0OMiyI3+BXwzjJVZK289Yp6hMoowawkjhZ/AZoSo1kyjLov
	dVQfYABrouDtRDXsvSbrG0UiOy98KdHYwL4oVSk63mD/DyFeIbiacXjUlHC4Vb3aOC0GKM2D301
	e3BkL7gy44xE33k+KzMFd08ZZq+iwAEdBljpZciH42aJoeD4A+l2jsgMNeCsGCwPqTBm/mTEnRe
	htJs1pdfw=
X-Google-Smtp-Source: AGHT+IG3+v2qLeP7l5LT+E1PZqMLuNyjQnEbtNq2tykfvKNcCgkn92fmgyAHFJDyMK3vS/goyWG6gA==
X-Received: by 2002:a05:6000:200f:b0:428:3e7f:88c3 with SMTP id ffacd0b85a97d-4283e7f8a82mr2908536f8f.50.1760888576985;
        Sun, 19 Oct 2025 08:42:56 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a96asm10812576f8f.31.2025.10.19.08.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 08:42:55 -0700 (PDT)
Date: Sun, 19 Oct 2025 18:42:53 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 2/3] clk: qcom: gcc-x1e80100: Remove 85.71 MHz USB4
 master clock frequency
Message-ID: <tqwmgsr5ilw7ao4ayuzi6c23n3qkgqn4yqqr73s3f7b3ehqjr5@5kn4h5bife6o>
References: <20251010-topic-gcc_usb4_unused_freq-v1-0-4be5e77d2307@oss.qualcomm.com>
 <20251010-topic-gcc_usb4_unused_freq-v1-2-4be5e77d2307@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010-topic-gcc_usb4_unused_freq-v1-2-4be5e77d2307@oss.qualcomm.com>

On 25-10-10 12:24:51, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The USB4 HPG says this frequency remains unused, remove it from the
> frequency table to avoid any misunderstandings.
> 
> The reason it's unused seems to be that the lower RPMh level required
> to support it (LOW_SVS) is not enough for other pieces of the pipeline
> which require SVS, which in turn is enough to support a faster, 175 MHz
> rate.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

