Return-Path: <linux-kernel+bounces-888042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C1EC39A8B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 09:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20E023506D3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 08:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A2B309EF4;
	Thu,  6 Nov 2025 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zpMBkhr7"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184873093BC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 08:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419056; cv=none; b=HBB3bEsfg0xd7aNXetcng2uJxlqwh8wj2TR2ELbrP8Kyy6jIpE8EJ+mKDdNu/3Q4Zaz/gCO1H9Ahv03HqsmN0AKOQ+Eb1JumoO5DXS4WHXPaQuqHQry6/pweAlpSsnx75BVkcuTsE7yzYzmkoUMuwrInv1FPeXxN5VOgY+kcPDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419056; c=relaxed/simple;
	bh=y/dw8Yeek5uiSFfzrYLyDpk4KHGZ2Q+0lMj56HOwE3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhY9gr7gtncdtK3jK0YrHmvWpRepNMf3HSQK/8SLuvYXLTdBjvNL2uGgyoLUl5FRYJcTaWtH4HPH1PRM7ojdQS4/fM5oC8NHaIty4frP/PyvgBVSQiwihjLM38D4RFlOSxuLGpC2bXxuaobx1oDoc4nwmj4N8X7UUXGgY2tfqZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zpMBkhr7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-429c8632fcbso492038f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 00:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762419053; x=1763023853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0O1+Bk0V1ecJIiIZPiuBQsoCpD34teqnebEkC3KejHk=;
        b=zpMBkhr7lpfrb0BndEugyEG98HARsRAOlnqU7cCJ8s+vPR0tkymgHv9TIx2jWP9ht+
         CHXG501wIUp3p/H+/5mDBgnSosnu/NlyX4MwkeNdLIXs7AewSDPD36a19QqB9lym0x8w
         PVHatOGR4ILuSUKJSkWmycF5fI+h3e1P1R1nEk5pb6ASahhfEWjBIWHw1kOj0h9NDn+r
         IdV2YPbWVovnaCMiXjwehpnKfH359rwrOHw0hkm5f1fYRzBQqtZpn5J90y4k46c9Dk4W
         RsZjauAXkSj2AJYIyviETBTvEILJYhQ/O7/bM170HrI/H4AfF2R1cmj8U4b0NrL9aKiP
         /Lxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762419053; x=1763023853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0O1+Bk0V1ecJIiIZPiuBQsoCpD34teqnebEkC3KejHk=;
        b=qzxkrUJCj4nYeFXoM3vDjrS8PfS6lhcg6Zh79ogEoyB8YDLDtO1PKz0i3gS3yC4pzA
         pz4MtXR2riig1ihqpXRu4AyildiiLVn80AsrCjAfV5BA2xRwX9DqHiHH84gsP8+tbQDK
         xcqH3GLOTZJPV4aXy5k/RtD0koZElPmJubY+sAEhBXpy17WtH5DFmXA1EWrVAwjD5lhB
         MgZRGSOBiOsvhEO0UXlsxcL0JHHjk6h3PGPYrq0qsJSwrATH4+KLYbngwxf9BwqcxjLO
         hbyn8gVTPrY9h/mrVuekjRbwN1qytozpwWCDgep0SOf57xI2IfEiWYpC554FliumJ7m+
         Fm0w==
X-Forwarded-Encrypted: i=1; AJvYcCXLhXO+FMaWUGXPzkDr1eeWJc2q6tBgGYhdYFTKpgyuT5Eb9pn8ZZONeyVsj6EAJUFkDP1qqTHY/RduRts=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqtSNUkG8tXkU43rd4eTmOQMIrEAFhWgm2skdFW1+D+XEKdxkO
	AVDnQEkt0vEam0msgIijF6+IjSq5V+4zE/+uO4kL83jUifGl5cbz/bTUV7pc+e3cf04=
X-Gm-Gg: ASbGncu+Cdc+TIX3dHvc9zkolk1btSlt51RoxWhglOI3S3sWV4Ng8waGAe20ZficgPP
	cAdRw15GAeExmdTkusDONOtPzcwWMb32Kgm8eJdaQipy+0UuJhV4E4OxgegWx+TZqGabOtt7iAQ
	313qlxqDKSdDy3n3Mk+u8K5sVv69842voa36LK4bJlXTF5hI93OfZ17E+jjE7eFAdwangZIpek+
	/r2/LdjQy5cX1v45asdMQ8RC7ZcXTF2sUBhpag7p+52OdqYF6Ogt09u3jRb5cIzBCNVHvarYyym
	mWt0SkoPL8vviba4QNvHH87Cz1bx2hc8IhrQ40fuA5EAPmtmNCzPz/DRpH44z5ViR0JBj0mjlOg
	DHD8OtpcWgn5Kz2/4U931WiUr8D/w8xqTea8CuvBYC1VNRvrTAGxzJRbacjezmAaWJt0+/2b2
X-Google-Smtp-Source: AGHT+IEpNkwrjClS3MRT6aT/Q6UAaN6LRZvZHXmcxt93frsHr0y/6tOsqdtfdy9Fugmh28HWQ5XyVg==
X-Received: by 2002:a05:6000:2a0c:b0:429:bb40:eecd with SMTP id ffacd0b85a97d-429e33120cfmr4859897f8f.52.1762419053386;
        Thu, 06 Nov 2025 00:50:53 -0800 (PST)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49a079sm3648338f8f.32.2025.11.06.00.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:50:52 -0800 (PST)
Date: Thu, 6 Nov 2025 10:50:49 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Ritesh Kumar <riteshk@qti.qualcomm.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, 
	abhinav.kumar@linux.dev, jessica.zhang@oss.qualcomm.com, sean@poorly.run, 
	marijn.suijten@somainline.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, quic_mahap@quicinc.com, 
	andersson@kernel.org, konradybcio@kernel.org, mani@kernel.org, 
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com, vkoul@kernel.org, kishon@kernel.org, 
	cros-qcom-dts-watchers@chromium.org, Ritesh Kumar <quic_riteshk@quicinc.com>, 
	linux-phy@lists.infradead.org, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-scsi@vger.kernel.org, quic_vproddut@quicinc.com
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: lemans: Add eDP ref clk for eDP
 PHYs
Message-ID: <x7ej2ne3lwn66xwgavdom45hj5imncczd5h5owufvvx4e3cblu@rdhb2adstev6>
References: <20251104114327.27842-1-riteshk@qti.qualcomm.com>
 <20251104114327.27842-3-riteshk@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104114327.27842-3-riteshk@qti.qualcomm.com>

On 25-11-04 17:13:27, Ritesh Kumar wrote:
> From: Ritesh Kumar <quic_riteshk@quicinc.com>
> 
> Add eDP reference clock for eDP PHYs on lemans chipset.

I'd add more information in here as to why this is needed,
specially since this is a fix.

