Return-Path: <linux-kernel+bounces-774876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35126B2B8AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CD7567193
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B700421C173;
	Tue, 19 Aug 2025 05:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hnbZ3Fic"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7CF1D88D7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755581454; cv=none; b=Gigtb1vugGzdVx+zRfFy05PiJ2oR01a96ispsq6p5/ei2GExMFMgiSRBEHCsplGFFEDKumgE3N7gq2dPfSLAOhmDTIZ7zJ+tw2ke9RNbkIiyQvT488AN8iNu/LOk8zmeQxTAjj+2ih6b7ROHkIs7OV33ZO3iK75oHkzR9XHQV1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755581454; c=relaxed/simple;
	bh=oNuneXdZUlONgY1eNYoigbQuliKO+uoIkFsryOlJJn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xvkgi7cx3XNgGVzzzyzJWu59b6yxORxifzyvvdM4IBTkTPhdat4zEtkzbvZIT8m26ACcSsKPa0J4zO+DMyESHLU5lQOoQwBfy3EGhJXya2hbKny5nQaUN1eGA4m2nGafsUwIZcJlIjrRPyuC9VOZ4SgM3UtLbJ7Vw8TtuJaQaTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hnbZ3Fic; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32326e8005bso4919684a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 22:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755581451; x=1756186251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NHADKkUG74H8DgiMJwyJ3n8CdyNUxQbiZqR+ru3KJ5g=;
        b=hnbZ3FicBWQkEZAt8mqK0GO8hIz5fuWZI+2XtjjQJsU+s8siymP4u9x+Kw2j4jsTsV
         XGpef7JJks/GdnRk2Y0Gfg/QBDTt1S/wnEFzsrKh4QDgfuD483t8Mfy2yo9cjEAkdwqI
         3ldddc0U6qxYys/0iXaxysfUZtR6TdZGVOl7DURwIc8qBPNnacSf1K4G5SB36hSrPh1t
         W3LsLyFCoh/Wb2cxNZWdA6YFPtUvYnPRpkHy94lpDX5HitlBdYwLlFFI3zUe+HMu9Hmf
         vdTCkJzxXtUVQhBFttkYEmxw3pNckby1XpUta9yUN4FsLk6FsTJhzAdCnAtBOL+vBtec
         B3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755581451; x=1756186251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHADKkUG74H8DgiMJwyJ3n8CdyNUxQbiZqR+ru3KJ5g=;
        b=o1fyU4Zb9t9UHQq0tGjEj14S3aN1kxdtyS/QwF2uFVXDXwjI25b5VLjI2KD2q52/DD
         uK0HX/wggkwT837ybclzX/HlRVvE4o2C8HUWSB7kqwGXDCSTNNxxA2zuzaM6okBvHDoq
         ptd1KpwLOoOwtDAMysiZU3SKmLv8ug6ojSf+msbymfOaD+xjYwFeTEbolQmh6dLGrEyA
         5e+lw9Nr281FdqIaM5FDbqODejjPX98OBvXWLyn8Toj1ZbjXcOQ/SZUPz7OOJnmkOaGe
         VjWcnBOfX9bLlwSYD8cyZo6EszFcpLVhTf6j/WWVd/f/HwZB8bvVTltS8tIMTwTMfzti
         AuEw==
X-Gm-Message-State: AOJu0Yz21Db+p5qJ5b2c9MZPgdWsZJEecMlSko7Z+hLCcFdy9fQkzb5t
	NviMQHWEvkYAia6iGku8i2W+At++9t4pemP7zFxvZMpjrSiCkOwBmYXXFstWGgZWYMU=
X-Gm-Gg: ASbGncv7bH14Af6y2bi61BBOLJ/ZsRk+mmAVLguoPk5J8RNvwYGrMPl/13+LwVP6V6T
	3eWP7snGc/YzyvrK/YGN91LTFoJCn2CYm16mR4MPowCpI9WsbKdpjzLAKl7DtHRotdQoIHz+vWz
	NNdqJ9JQ5TGCTuOh7LnHKHY/KFULEmiOrvFDId+CDP2Wi5CAk/KXZxgj0263skMhSIbvf6mN2Dh
	D3xw2hPuMs6sFBACSr7HOQZQyNye8UYF44351bvJPh8LJ9wi6mdi9vEzKTJ3zvxGhriUdd1dN7k
	gdw6H/GNMDL/LpRHu1BqYyY9ChIPIHvn0gWQGG53y0NG4JbOrGt62gId2xNo2WvltNsFsv3kShc
	1HqB5SsZvLb9DqmMSeQgr/QurEe/QcV9pMCA=
X-Google-Smtp-Source: AGHT+IERt6oCE4RMNflHw7TCKFgdRx6IB0LQJLR9mIihyCp5VdPHl033jFifzhuL917Po4PZMKKnDg==
X-Received: by 2002:a17:903:290:b0:243:38d:b3c5 with SMTP id d9443c01a7336-245e04ca7bfmr18923145ad.47.1755581451291;
        Mon, 18 Aug 2025 22:30:51 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f55esm97139685ad.82.2025.08.18.22.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 22:30:50 -0700 (PDT)
Date: Tue, 19 Aug 2025 11:00:48 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mike Tipton <quic_mdtipton@quicinc.com>,
	Peng Fan <peng.fan@nxp.com>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3] cpufreq: scmi: Account for malformed DT in
 scmi_dev_used_by_cpus()
Message-ID: <20250819053048.t3dfmyu2xqd4ypef@vireshk-i7>
References: <20250818155048.551054-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818155048.551054-1-florian.fainelli@broadcom.com>

On 18-08-25, 08:50, Florian Fainelli wrote:
> Broadcom STB platforms were early adopters (2017) of the SCMI framework and as
> a result, not all deployed systems have a Device Tree entry where SCMI
> protocol 0x13 (PERFORMANCE) is declared as a clock provider, nor are the
> CPU Device Tree node(s) referencing protocol 0x13 as their clock
> provider. This was clarified in commit e11c480b6df1 ("dt-bindings:
> firmware: arm,scmi: Extend bindings for protocol@13") in 2023.
> 
> For those platforms, we allow the checks done by scmi_dev_used_by_cpus()
> to continue, and in the event of not having done an early return, we key
> off the documented compatible string and give them a pass to continue to
> use scmi-cpufreq.
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Fixes: 6c9bb8692272 ("cpufreq: scmi: Skip SCMI devices that aren't used by the CPUs")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Applied. Thanks.

-- 
viresh

