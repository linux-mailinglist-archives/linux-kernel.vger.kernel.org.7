Return-Path: <linux-kernel+bounces-852497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C29BD91E6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C14E4FF166
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5273B3101B5;
	Tue, 14 Oct 2025 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R/bVAIHJ"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B0030FF30
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442734; cv=none; b=Mkx3e0nJ9hCXvQzLAQds3Tvqi604/otFomxHPJMBF4DEQC+sb7rQ7mntIVo8UlFfqst1Nyf6CTwcKWNVk/CtC/S3hMdNWlgW0zjJzEkDz2q6feXmaRylEeZReZ9OpbZh15xwzGhIKRPTRl2DPWMT8BdQEOJbx+thiYT58IztVvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442734; c=relaxed/simple;
	bh=C4Zwi47MIN47+HMZt7z5ewf90C8CD0KEwxfGhCDU9l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/4CFt69nQXvWItJhQ3krZ5+b8wg+YFYKzLZ7OXlOzOSPdcRwrnuJy5nsjvWNyz9nRc+I9c/2XSjkseRU1uYiQslU9XuNYfqRGxabP3Kpa2/qD40p4a0Uyu1YG6CEmtTdB3SUl3tSlO1YmGXLXOjJi1zmMhU+t5ZUfNhMUnBqAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R/bVAIHJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e48d6b95fso46024865e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760442731; x=1761047531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S5kwp6ZoI0Qw9Lio9IILJuSek2MXZc7hvFxHIxIa6Qg=;
        b=R/bVAIHJfCIZYlJSwLQaunMl3C3ZTP2ijIPWD578I7cyOkYACaGLG36bcjYk5Rv1+v
         kPcUV38je4qpQC8RoUY9hEE1kHTawfOld0R9Q6cZ59CkKoQJUnafSQ250r92qaUO2A+q
         l/WPFO3iIA0y6k6IyjwEfPXrv6/jblOt1bVB3KBGahBXKIdC7Clo6CbCRI1sjsYPJ+zk
         aVqt8FLmU/Yn0DDDyHd5MMI0KtBn53a9EOvXs8ur/cSCberUx3Wjz5YE8gRsX1B3B6Gh
         MZoF+5XUcYBGFSHOScZqCmQ/mcLX6yeLlEhKU+4ef41F5whnXkmlP9f7fr7t1avBf/QB
         oAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760442731; x=1761047531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5kwp6ZoI0Qw9Lio9IILJuSek2MXZc7hvFxHIxIa6Qg=;
        b=Kh2ZFmZBYqvIxHzKGVxoJ+HRHI0ldfkeW4dWF6kjblOUM/DQxCM1I0YwlXbg4SzIyF
         2/S4pX5XEpe5opaSitzqndqwhq5Umy9EhVn782opkqBQjBxtkgR7Q9H8Bu0FjULcP9J3
         laCoPibtoVVcg8pSLWiWyBVTTqqkMDzwGLjd8lyRUF06VhzAukApSFFhnx20Q0E/0NDU
         CBrylTv6kC+TQWWx6LjDDGR1DvJ+rEqOjE25YjoG0Y0AouL2CNrv5Mz0Tg5EY09VqZcG
         liA6YDz9ZWqKi6IGkGA8kDgEqlhfFkn93keA0HdOlp2EbjzZ1po+wmsULUlwxtV64PwM
         PIiw==
X-Forwarded-Encrypted: i=1; AJvYcCVCcJwEHKIT6k85Hi0trCEq0dFq005Nea97z2xZr1geEqh+gNW4xvP1SqO0Hb1VBXNyh7LASG0DySN7XWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGZqYdMyZ032NWdjslePNCakiMseM3ezpBjTfEO1lbvPx1TXSa
	hWaYtcqdvBkIoqgsbX5699dzbzWkwMEVLBNGkRvq/LC2XyseF4Ebg9F0V0Ir2FaKHvQ=
X-Gm-Gg: ASbGnctZNWiUsmzEQycnVRG6Sy+JRetRr7LKQKQnN0VIRg2Eq7Wji2TdRJTLKIpeAjC
	zx5JxWQnbYhVUkhUYCg/Cc95d4S+XS+aG9+PInb/e1Rzhd+1j4goweiYMn8idbxaFG23iP9+lS3
	2B0Co9reN7Bfbl5P02feCEXNY08fnprFGAeJFXUGKtf4AEzHKFcj2o1LqOOYiGXkjMWedJuV5IJ
	1Lw3pHEj6jk2uh5Zz4Omd/dOeI1LONv4UvPv42dbW54NfQlktJhB33Lq9nUGNP9eAUGFy/sigjK
	u5YIakYfKuIUZjJS8AsDQXIR2voo8wfyoWRJ8lwgccyT3VM2X8cwAJZCAyBud07tkeHMW3R9+g3
	VTb4Hl9kLghMw+oOeCY4mBPqNASvJC7d3IJU6yRUzEZrhxGGDi1o/
X-Google-Smtp-Source: AGHT+IE0T5cvpE7QhDWujs9OdISYV+M+qLIfcBtU5FuqXOEPjcO1IUVOft+IiRF/W2H0Fcynpk8rfA==
X-Received: by 2002:a05:600c:3b29:b0:46e:7e22:ff6a with SMTP id 5b1f17b1804b1-46fa9aa1d79mr180603815e9.15.1760442731072;
        Tue, 14 Oct 2025 04:52:11 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb489af92sm255991685e9.17.2025.10.14.04.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:52:09 -0700 (PDT)
Date: Tue, 14 Oct 2025 14:52:07 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: display: msm: Document the Glymur
 DiplayPort controller
Message-ID: <mugh42lzc64wfkcacwo3z3pj7o5m3gx2ksjh47q3q6gu5dwqly@vfvs2n3czy6v>
References: <20250911-glymur-display-v1-0-d391a343292e@linaro.org>
 <20250911-glymur-display-v1-3-d391a343292e@linaro.org>
 <mgbv5zoptfox664jswi3imvibrd7d2teazeuied37dw3ooiex5@lli2bsap7d3x>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mgbv5zoptfox664jswi3imvibrd7d2teazeuied37dw3ooiex5@lli2bsap7d3x>

On 25-09-11 16:01:30, Dmitry Baryshkov wrote:
> On Thu, Sep 11, 2025 at 03:28:50PM +0300, Abel Vesa wrote:
> > Document the DisplayPort controller found in the Qualcomm Glymur SoC.
> > There are 4 controllers and their base addresses and layouts differ,
> > therefore being incompatible with all previous platforms.
> 
> ... and it's a new core revision.
> 
> BTW: any additional clocks or regions for DP?

No new regions and AFAICT no new clocks.

Sorry for the late reply.

