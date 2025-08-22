Return-Path: <linux-kernel+bounces-781175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE38B30E83
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6EB35E38FA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FD32E1F1A;
	Fri, 22 Aug 2025 06:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DMJxFvmD"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690CC2E0404
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755842774; cv=none; b=sIog1RiqY5AE7bvIxrocLpRI8j4FI2cgIgSoUha7ZGMUVfIxc+AKBuGGCsherlF0st3hPTY6MwcjoJzvtrXrisqM54z43VcxY6oSdp3viJiuFmfS1dICG935o4SXMExpWDXziuFhUNEo+rdCLj1286lDWJTQln6Bi0aSDjv6p2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755842774; c=relaxed/simple;
	bh=HGqWuoHgmmgHoSzHhFhnGFrp/claoOUiLRgGZX10r+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVqjY24efz1SiSUYN5J4r+qusNHwk2D+4FlD9E7oGsOXtX8ZOi8TKMoFCmwwTUnirTVtBF3czfae/MsKfHG24nbFs5d1fAUFP6FH070VsQHvvX8MbXjXXo+hN6xHhnEOWauMbbnhzw+/At9y1r4QnFgAynTVNcLAD+nVUjBj3/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DMJxFvmD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so1703159b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 23:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755842772; x=1756447572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aRj4gWuvSe9KJNF2HvWgOVVCeMpYCcJ3nSN/Zd2LcHQ=;
        b=DMJxFvmDwwnfaVQEyBimhTyC3/vAl8YX4HmwenkWr99X+4uER8nR878f8WzC6IojkE
         PkVHD2fbFmLVpx/ZUobGQcsP0SexyAfVEYBJ9v0mwF+wbOaglQwObYtVjCLdiCjmFVEb
         h1Ns+UasMGZYQmHjmB9MbKo+rtGKjsRvJ4g5tyivd7Uf6R3zFEkQh2y6vL/QBW954EqO
         4LeluaYYWFlRS9AWaryVHcGXJZCCFtG8YCOjH+qtESboqPBE1fhv98sQmXxBACha6/Lg
         dID8CWqtyH9JIP+k9hAgEDcnEx4OGgcaDs5uNAwvikhGXLmnoub40MJFmkBZK1xLIuyH
         G5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755842772; x=1756447572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRj4gWuvSe9KJNF2HvWgOVVCeMpYCcJ3nSN/Zd2LcHQ=;
        b=Cb9y+mwTXdEw+y8SQXYz+Q6HwCRwN/wjEUAwSBPPq5gijyUvzujQIbdbxWD3mx9d+t
         XZKjFx5fjI4iY5PzOJ0uhSpYk5UfaBIfO121ESzHVrORaIfHD17Hrnw3NHPqGJ1aPR0V
         ZkL83hEWzSUdn9b6/a5fp6Y/1Q2bCpHNt4GxdOQPbp74tEBet7jiu+xjFeylciceForW
         yf+7yH/q9ZFp9aSJnlHk9equzK7uJ6rbGckkZMc/v3wZJdoiqbM+wTQc7bqQIKOPif+S
         vydFTR45aLsSMi8RJDfAblnXdPh8fcLsvt+1J5+d9xIySCdYmESFpj4bhHEHShwVV7dg
         QKhg==
X-Forwarded-Encrypted: i=1; AJvYcCWGOyRRmWzsZoDolmy4378Bz8kGy7b2fPWP/yDywAnkNA4BQ8fFqX/MFZ76JaHH2/ot1jgVqUsE9cAxffc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrDJnCxyc1oUKMrFOcnGhPfDFCYCLQ54fSTkwoeU+CAY0/p/2G
	scAB2RJS5TvZyc8tOvSDx9wuDyr/hdJNirg3KHgPIvMkDyqIexiE7yFojmPP35GXr6Q=
X-Gm-Gg: ASbGncvOUCjBDAn+vqSMy18ybBhJpyY6To8bO926Y3uqqCEHLIb+gGZ0p0/5CtIqM7C
	6D+q/oXA+JnqCSeeG8MBCaRcUf6yP1ERj1FpHA0o+OWu9TknyT3Cj0fKDVoD7kpvo6Wqd/9me5v
	iF5GxbICXpIXVeJdkQYt2SrEm9XBedKP8TSxMtRG4dR+MQnzS6YO/O6+lLG043ADLPFFT27a2jp
	br/Wj39IeAopfrfrVUkN9bJMI5M8vo8GDXW1cinqNwOioWuO1k6mpXbMY5XXzIpKLqmi+rtQUly
	4Ox0Wv2zTHRlHzroecclE1rDVxJ/GKRp1xFnqaty0TVyS9E4jt4Pe8sG2ijn6sr2O+wGPVbvVi/
	kYA3/v3aj0Oal7e7E6O2+z1tB
X-Google-Smtp-Source: AGHT+IGryQhx7NkdJSDc5m5rZZNOBqLyR8DTgK4iIdr8kRPK/dFFCXNh+UbON3GVXLnVhVtonBLu0g==
X-Received: by 2002:a05:6a20:3ca6:b0:243:78a:829d with SMTP id adf61e73a8af0-24340e4640dmr2844133637.54.1755842772379;
        Thu, 21 Aug 2025 23:06:12 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-325154999f1sm1475868a91.25.2025.08.21.23.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 23:06:11 -0700 (PDT)
Date: Fri, 22 Aug 2025 11:36:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Judith Mendez <jm@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Bryan Brattlof <bb@ti.com>, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/3] OPP: Support more speed grades and silicon revisions
Message-ID: <20250822060609.djvsm5nmryit5ypl@vireshk-i7>
References: <20250818192632.2982223-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818192632.2982223-1-jm@ti.com>

On 18-08-25, 14:26, Judith Mendez wrote:
> As the AM62x, AM62ax, and AM62px SoC families mature, more speed
> grades are established and more silicon revisions are released. This
> patch series adds support for more speed grades on AM62Px SoCs in
> ti-cpufreq. Also allow all silicon revisions across AM62x, AM62Px,
> and AM62Ax SoCs to use the already established OPPs and instead determine
> approprate OPP application with speed grade efuse parsing.
> 
> Also fix 1GHz OPP which according to device datasheet [0], also supports
> speed grade "O".
> 
> [0] https://www.ti.com/lit/gpn/am62p
> 
> Judith Mendez (3):
>   cpufreq: ti: Support more speed grades on AM62Px SoC
>   cpufreq: ti: Allow all silicon revisions to support OPPs
>   arm64: dts: ti: k3-am62p: Fix supported hardware for 1GHz OPP

Applied. Thanks.

-- 
viresh

