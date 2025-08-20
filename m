Return-Path: <linux-kernel+bounces-776984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC30B2D3C0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D980F627B09
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1497A258EE9;
	Wed, 20 Aug 2025 05:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YXmymuyn"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BCE7261A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755668884; cv=none; b=Qbob7qRtJc8qBmV6evg5cGCEsc6VoIM7MSkFykRQad4yabmLioz8Tz4Are/1inJRIsumcXjy0amO1MjeV+KZG7V984vVey+xbU6ph4OdLAIEQRgc9YQlinlCP8J05yy1WWSlrr4JCVeuE9qdxrBv6kHdgfXPSXCn5m+p/Z5fxnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755668884; c=relaxed/simple;
	bh=r+w8WvwWHNQ4VwOfdxeCscDSyg5iTvG3fk5pdUlOBw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4/4sXcDhvDp7p1o45rW/gnTtVBlUTRXhm+Z90NYb/i7E6TyouEjqw8yTzoTFBoipVxFzDqR1y/wGGCahEdSxEynuWuDN7VIbIhtGmOtaFSP3SqlufJxsA7u+TNMSBAB+GxWOYDtCH7pkUvxn/g2bXQzXCtMZ3X76WsYMJ0bMek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YXmymuyn; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2e89bebaso4495679b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 22:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755668882; x=1756273682; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vW8840o/ycg8xvcBZ4mzSNjiiU65u1hBI4Xzd3lb1KY=;
        b=YXmymuynHBdxEF4HlAV6TTIOgR+nr+wxNh0sH64TXUpd9MoPQRvnFHaNmLyhDiL8OZ
         NRkgiSdHB9T2mpo5NyvoTP0R5vw8Uzxw4AfAGkGz6MOTuRxBzv/k2aBoMwD/m75pCEwT
         IEA3jdlgNVkm/qg40/0C4+sDht3kKQHbNnlekZv6w0OwjtjRixgiKiv2Zf885sHB+uyW
         dwisMqJZd4NavO7aUbkYtLZR9DBJVr4fQDRUEfPWIu+p+iCVPye8zMCXh7bFI9O4ZxW8
         MeeZoaIzDHA0YcmZEVdJKpiXPYjsx7F9+hzwAv/gyutWwnnJTymZjONLHhGdZVDYIePL
         Ylpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755668882; x=1756273682;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vW8840o/ycg8xvcBZ4mzSNjiiU65u1hBI4Xzd3lb1KY=;
        b=HFwKSiuMH7uoKTdMrEkl2/PvAaxqRfdheYL4wRXrHglXgBoMRvrFjQeQA/qxEXinUI
         JgXsbCzAmoVF6F4snurtBtJCQxcJpNf2NY9Ih029+mO9LYlkPucW9f1HodIRF+0M81YT
         QNFZYKKXkgUqOBLAWqAmBAoR1YonSrtuI19umTJ1PMEPj9ly7JhayAR78YumzgYQRqLk
         khLf3zNCbh3e0snDA0MXHPtjD6ag7OG4Hl+CxmynqCkmQbiHBJth/Ly3KLEHplzjC/wD
         +tIAM0IizNxOP1V3cHf6XNF1oyjzIybzsDP1DYRjH6TtJR+TVepsAd3ACHl13giY/PO4
         7HAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1v8vnS/iNIOlK31JKyhROnOBqgTc1E1UhbiGPDkZG7tmVm6wFVI7BM3lyf+MZQJVi3q3MjUbEW4VOjJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhoVuqeCZISdpvIYqF5tFRVrUq8LvobDnxmuKhSnO1I/jvP0Pi
	FFvw3fpFnGiKNUH2iWoSS2ym9d7fPdhKM63v7da0b+kX9meL8j0GeG2xdOo9Zazv3ZE=
X-Gm-Gg: ASbGncteZC51lxSIAU3yMIZRmEUKKnMoFZgRHzxGxw/d2IR8DH6LBa2ULjA1uCi4D75
	5Ky67w6Ql6fDXYxeLxl4X/lD/jaUFxLjZduOZth28Sm2xORmntUxWEGXJU5a4AC3nx8Cf3yXRYL
	1y+HjDMSimCSKYHJtkXH+q5HXHRuJ/rM0jCcGYcTEvCtv/cN1GI0fzj357tUdayFL/CguGLuxHi
	RJnHf8cb0A2IWdxhgeh7qXC+mLtVek60IkGs/KNc7Z7XG3zitMkwS4IrQz/xork2SshHp82V4rv
	6iXyLKaZMLv1vRlb7bEanB2WWcr/2ewJfbaoRyEK2FbdFe7FO8qIPa5Glfw4nHQTJNMJsHK5Jt2
	hmIW+wTPeu1JJKkckVH3+cAyd
X-Google-Smtp-Source: AGHT+IH2Xq01l1q2X39vBmw9ze+Dsd/H2thv74xC2wrCKl2UpQcwUaIMycYjfq6gt0/zvw2HiqQMAw==
X-Received: by 2002:a05:6a21:32a6:b0:243:755:58b8 with SMTP id adf61e73a8af0-2431ba737b4mr2735426637.57.1755668882295;
        Tue, 19 Aug 2025 22:48:02 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324e250e52dsm1075206a91.6.2025.08.19.22.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 22:48:01 -0700 (PDT)
Date: Wed, 20 Aug 2025 11:17:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "rafael J . wysocki" <rafael@kernel.org>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cpufreq: simplify cpufreq_set_policy() interface
Message-ID: <20250820054759.iewwi6uvsvowc422@vireshk-i7>
References: <20250819103940.342774-1-zhangzihuan@kylinos.cn>
 <20250819103940.342774-3-zhangzihuan@kylinos.cn>
 <20250819105925.34o5f5attd5rboh7@vireshk-i7>
 <ffe2344d-e825-44c0-ad2b-9544b123079f@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffe2344d-e825-44c0-ad2b-9544b123079f@kylinos.cn>

On 20-08-25, 13:42, Zihuan Zhang wrote:
> You’re right, we didn’t really consider that case before.
> 
> The interface of cpufreq_set_policy() does look a bit odd:
> 
> - drivers using governors don’t really need the new_pol parameter
> 
> - while drivers using the setpolicy method don’t need the new_gov one.

Right, one argument is _always_ unused. If we could have handled that via a
single argument, it would have been nice.

> I guess this might be due to some historical reasons.
> 
> The question is whether it’s worth modifying this function, or if we should
> just keep it as it is.

Unless there is a better way :)

-- 
viresh

