Return-Path: <linux-kernel+bounces-779485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD81B2F4AC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85603A6EAB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99EA19C542;
	Thu, 21 Aug 2025 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FkQ++P29"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF45A241663
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755770200; cv=none; b=DjpSkCab5nCfB3KP6DsFxzenwEB7dXbTl/BfwJzNc3LfhnWX5q+sTuzP00d4FtUgfVJEUq2Az6Fv6qNQuCTnmQfSIPBGxVFyJnQakFMaTynyZOB+qw4WFNbQsSH8aEj11Ot/guEcCWqM9HglB73XDB8brRlLa/HNUmtQqTIK978=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755770200; c=relaxed/simple;
	bh=o1UwzeJaWw0kVzZcs7AuVVxIFiL6JiO9mw8gh5/NBRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5vFrQCQ9eVWkkAgdBd88tp2OdqIKtfX41NBwLjgGhCoqC8MEh+7ppvqrE9IfT7K35CEatitewAhWgyOKJ5i0b4mWIQWwuxAeT1msxOd1US2/Jfi5HSxA/SlZ0HxfdReANFdrvOdfF4ut5hSG2+mn/W6F1vGdwCEfn48YhRjhsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FkQ++P29; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e39ec6f52so1138863b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 02:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755770197; x=1756374997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VT5ngp3FycPHiD/nyGuyIYkXo9clIL8VxY4Dzxjkou4=;
        b=FkQ++P29gbVDaA0yzR6JLORbp7FpoflNuELP2odHf6rsfmvNcU4+yvt/38Y9pB/3V4
         S+o4p1xQH+A+faZesRtlJs6mr1rc5BCkV5/9vqd7HwsmHveUWWGeTKRVa1afK8QHASsW
         uJfn8zDDIOCRWveyfsJtEBjW3Y/nVjI6qXTqwnaR2ivAIJQzH3Dci1K/O8HOnX746wKG
         l/GLmCgRFsVDnuKInVjdtRqH765dlTvTSkzLjpFTvDnaNCyTZK76huEOZ5iNsBB3VO4e
         V6YUVKGGeg/IwIxveIpJWPo2Htqsl5JGzhyjkIG6czLTbFKvSxGH/gjqKX+vTln+A48B
         lhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755770197; x=1756374997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VT5ngp3FycPHiD/nyGuyIYkXo9clIL8VxY4Dzxjkou4=;
        b=eZGMxovC9pfk4Cys+b/6Rt9DCruxUt/jC9By1U7vPo/Y6SfObnxww4De//16qOR8LJ
         VwFi3VYanzxniMzV88rs+8hFAlSXNO5bNOqFCvqbIOIBT6gbgdX0CdMHNGgUqj/qD6i1
         LIg3taaVw15yvMArSij+HPrU2rAKfEKB7i6RpjEAguRKAdLxIBcilTTMvnKlqUzb3bxy
         75zxBdv4KwNTvzTPl3qu7qtifNKM+pRXPM05JFXr+TaixYHD5t3geEbUQixIXxgz/SRV
         rkTBjo+rAgim/uXoAtj6qHYljw94OZL3wfyxVBUwfd22UEmOXhTgpg+3zKSsnfeR526X
         XiBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWICk8i0Tc0DZ0hS+fr9Upc5BXzR1HhUWRfIuwD7N/byOzflLyfAhI2FS09ARwThpLruHksGyhtd9+ofWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJtnT4N+Wc9/WtMV+zS09FMwR7NuqRW53jox6Rln1Xfi+j+JI7
	4pm6qgjKZEFnBoz8kiJ/7z8JqOZYhipiRW5DrY8jAk7xgUTZqMYtJIujUesfEhb3U1A=
X-Gm-Gg: ASbGncv4TZtlsTP33YHwEBuv1g/ZtSaap6PXkeSR+vTUYSW0qCYI8Y8oqEbaQcNm6yA
	UZ2bZBwWiFFbagFt60+uz27cFqT5yjWgBkY0Os87BLRlcRJMf6dXU7G/W1ZTCRlskLpZ5nhoKT7
	R4i+tLs4okpCo6v3yDtXfv/oSAJKT5z5ZK0La2zf9wd9/sThtuY56U4ipSMIHUvncoSDk12p+Zt
	QsprT49OaqDnIi2AiOiCy/qBtIc7qvRI/f5C59SgyIjb4kstebtt/hPosd7363HirPxlgkw9sN3
	I5NVqIm9MwO2AqeErW88c2l+PUr1J0gUkeaVIZykijm/ozF4Fu8OCBJJksY2ZYdNfjhtOITdtsp
	xUYiMNgWBcfrCKMTJ26BaL4Dv
X-Google-Smtp-Source: AGHT+IE/FTn+NnaNN320n3SqkwO2WSe747XNHv/lnN4XuSlccAH09sc2Fd0+XKr9ZGuYn4L06WhfNA==
X-Received: by 2002:a05:6a20:7d9a:b0:243:78a:82aa with SMTP id adf61e73a8af0-24330ab897bmr2399858637.50.1755770196908;
        Thu, 21 Aug 2025 02:56:36 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fb9bcfsm4363243a12.8.2025.08.21.02.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:56:36 -0700 (PDT)
Date: Thu, 21 Aug 2025 15:26:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "rafael J . wysocki" <rafael@kernel.org>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cpufreq: simplify setpolicy/target check in
 driver verification
Message-ID: <20250821095634.t6hfkmfkzjwsy4se@vireshk-i7>
References: <20250821090020.167786-1-zhangzihuan@kylinos.cn>
 <20250821090020.167786-3-zhangzihuan@kylinos.cn>
 <20250821091716.x7y76wfvvez6g7el@vireshk-i7>
 <b72c666e-b286-45b6-92d9-7c6dfe5753eb@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b72c666e-b286-45b6-92d9-7c6dfe5753eb@kylinos.cn>

On 21-08-25, 17:45, Zihuan Zhang wrote:
> Do you have any suggestions on how to better test or handle the cases where
> driver registration could fail?

That's what I suggested earlier.

> > I would rather do:
> > 
> > 	(!!driver_data->setpolicy == (driver_data->target_index || driver_data->target))
> 
> The current version of the code is much better and safer.

You can actually do this.. This first converts
`driver_data->setpolicy` to bool and then compares both of them, and
both can't be true or false.

-- 
viresh

