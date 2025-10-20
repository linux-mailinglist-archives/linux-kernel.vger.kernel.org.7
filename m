Return-Path: <linux-kernel+bounces-860840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25899BF1242
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3724E3AC51C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593E031197C;
	Mon, 20 Oct 2025 12:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pRj+KyPW"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F207E3128D7
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962719; cv=none; b=OmL0aedjWETadeanJFo2xpbl0aMGofwWo8HYOBk1XAdqYfSPyMvkn68e36mS+ahbP65qpFawtn7EuisJoqPW9Ogf4FJuuvPlcCBIh8owKZo9SYEexoL5Xn6cxe3ahvBlLwReidmEMZdQzs+5WY1xdJtknVYdy2hbU56raASqFUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962719; c=relaxed/simple;
	bh=8a8AR6tiCU6DFQ3mg8jBjjoUZhwx7+JJL0g4l6drVNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7DvFrCf/n/sLz0AshqXiLqiIqYVSqgBJuz53sUODu07RuAYP38J2rWb+RkT4yzBT0oEiXIvPl3PT3Gai4g7Sns38kVWAokiwd6PkatJf2py6+qdg2djtjU+bj0lHpbWS+QVbOOy1QK6KDzeqtwal0e13F8AYoRGiHK3Tw3SJa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pRj+KyPW; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63c4c346bd9so3899282a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 05:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760962716; x=1761567516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mHtoWy0rW/Dfa0K/dIGZkJv1hj/FYjxxGrknVD25rf8=;
        b=pRj+KyPWrkTIdnv7YGRt0B7woKEkF2ePySDDIiHidqCeT9jsbQWw0tmSutPgBAhJ+6
         m1ikHhzNhPMxiDDRM64B3ZH2TrIlUYNLjv5swCCUkvL3cFzNgDboDaEC9gZrOMOegMq2
         cvSuFABVs+fPUxYl1Kt7QKIYQpvl3kSY2rwdaWZMhArBKQX1iefhaY/fv/OcITat5o1N
         yhiPyzT9uxZha5ZYOzP1Okocw+gGci3uqyZfwHu5vzc/qp1dYUguAIfAbKVWRT0B+0jb
         wg0OSG3O5CYN+1nE3HoOK2kSp09Yu4gAYVzVJzHR/LLbSzEQFsSWuMUxqLkeoMaozT4c
         UvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760962716; x=1761567516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHtoWy0rW/Dfa0K/dIGZkJv1hj/FYjxxGrknVD25rf8=;
        b=nvw3nwYeTPSW3WNQ15WIhIXUF+1PPQgYtRlMkFgz99fsXdBLZbPekKgE/sS3kNk0c4
         4BzPGzaBLSp95sVUjbH3HXU4pntKYhlxJJaQSb9CV6uLqTLOmPZNh0O2EeMqeaPf9bpG
         pa11QFZDBc77irW7LCopEuyb5kqgMa6pk4Q5zlFVrLaGM7SL92yMO6SDoT2zT1jDrncC
         laOf3f5FbHyC0onS/MgJn4yJqqdhTAOQ/f/s5M5Oa9foKZPIfEE6CUfeIr/GBziNAhWT
         d5w5G8sy0+Qb3ZXOPlcc+VxCLJg8l+stECsB6KOtDSaEWEv4Sueq/MjMKNbIJKIfBNl8
         cz2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVN4ZBzwGHMx0myg5zI7ysuEyjNBKzO2JVV9c5W0i332/ZlP+nhQ4JTDUjBfoxsxJ5gnS2nHouOwkWhbw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKhTB2+WT7S/AD4hhplJhIXiurF8i4uEx77tYiVfyr2R5gKBSU
	0L6iB829hmAhzUhYzmkm+M7xh5sTGC1+S1kHw2HPUjUqRXNnAxD6/9LbAve0c0u7Juk=
X-Gm-Gg: ASbGncs6KiBcEIlUxrtZxXAZpogu+OtNnzc1shyjoZYIs1jlAZpRiovcR9Wt/d3Dwbl
	F96LtFBRpGwnLnkSKGESijOgNPXA8eKzJMTxWXCiugvSbgT+6CIBJkv7Tx4wILuqtD3OgK/7Xw9
	BSVVVPLtgSDDkLxz5/Vr+ZJVG4rX/bpEpONsGR0/2h7nYGJ95t6/ziFyOq4btdPNGtdXJTnUpNC
	3e4WIbgeOcJD+us30p9UYRT8satkwaAmCiziWAdikFNnf4jOzPPpGAdcZEiTMvGR9w8pVuNzt0j
	aQXV6/oVW+Q+v380vjIYyBNRFpoBEe4zZrwaWb/4lYJWa1JWjPvJjEOiodvvj1sf3PC9YQec57+
	/Q96oFDs4JrCRv3R7fctEqKAqgVec5k+vSHBZWYmxsAi/qGJa8cbfxwNUZR02p61NA5fKiISl+9
	BeutWQTy8=
X-Google-Smtp-Source: AGHT+IEYTKLbq7qE2pr8wxA/yckx1iXmo+BlNHAbmHOkOmRXJq652IxDbU9LA6fH4X1E2sL5qKkwnQ==
X-Received: by 2002:a05:6402:2787:b0:63b:efa7:b0a9 with SMTP id 4fb4d7f45d1cf-63c1f633e3dmr12601718a12.9.1760962716133;
        Mon, 20 Oct 2025 05:18:36 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c494301aasm6738466a12.24.2025.10.20.05.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 05:18:35 -0700 (PDT)
Date: Mon, 20 Oct 2025 15:18:33 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdx75: Fix the USB interrupt entry
 order
Message-ID: <w7jln5k2xaq3iu23v2z3auoychicjgrbpvavsbvb2g2fjk56yq@sramtyump6s2>
References: <20251020-topic-sdx75_usb-v1-1-1a96d5de19c9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-topic-sdx75_usb-v1-1-1a96d5de19c9@oss.qualcomm.com>

On 25-10-20 12:13:38, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The DP and DM interrupts are expected to come in a different order.
> Reorder them to align with bindings.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

