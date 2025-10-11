Return-Path: <linux-kernel+bounces-849017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AEFBCF05F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 08:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BA284E4C8B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 06:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359FE21930A;
	Sat, 11 Oct 2025 06:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="XwsDBCkx"
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D007B3E1;
	Sat, 11 Oct 2025 06:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760163460; cv=none; b=P4KJuYHKTYk3gkMhtlTYxfyZhA3YbFegDEmTlL9HiQKUYlv+3fp1/3s2lGJVr8PvkMRLsvUtZ2uf1Mu/tfO8bcWF3keTyS7ImGdSuN9tCvq8kuwCqZ03wmiV/jroxBCXbpGcAFhMeo+NsEWWDAXm/HDDtayVCp6QZrlNH8Nmjrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760163460; c=relaxed/simple;
	bh=TO4f2gcrQnoMEYt9mg8zQzWHu2rGAOAO2v/aguReqFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lyBDYjF0mxIxgFC0LQg0hSJmXk3v58TqSg2NrbeVOcrJQ2HPoHVIT94QFgMSA0LwJeFWp6HwTiMuvGmn45g+UXHinwjFDgcBbmldU29U+NKzZ9XEM2X3iN4n7hGyS5p7z6ExvifWDi4RKTxeu8CE/7nFoylD+dYPUmPOkWEk3Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=XwsDBCkx; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1760163394;
	bh=XawiPTjJ32OCnBG00bWtkmlDJRYbRKeTBCT9zHx5Diw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=XwsDBCkxaVDI6UnHiNV0zjbjxnOeT7UQlrBSsflHLVoNjR2vgqfwwSu4Hx/yIwmec
	 F2ekShQAE3KsLI9/oHWt9KwLfn4x1qvGuskLXLi98xNnDdvF6hPHWf4gj+/52pRIEb
	 p3Qdc1N0stuu4r8X9FrPpuYcQj6pabW4nSaiFTx0=
X-QQ-mid: zesmtpgz7t1760163392tc8a2af1b
X-QQ-Originating-IP: splDXlsRjlS/Uy1BroH0SUOxddGqrDTN9broTRqjim8=
Received: from [198.18.0.1] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 11 Oct 2025 14:16:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5847224888410991873
Message-ID: <5765996267362A79+7284a202-923d-4b02-99c0-b2a6edb01082@uniontech.com>
Date: Sat, 11 Oct 2025 14:16:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: gpd-fan: Fix error handling in gpd_fan_probe()
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, cryolitia.pukngae@linux.dev
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
 error27@gmail.com
References: <20251010204447.94343-1-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From: Cryolitia PukNgae <cryolitia@uniontech.com>
In-Reply-To: <20251010204447.94343-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NWujniBqiFoNJYFOzB0SdBzN2kaXBimVkGW7Ar3KN0rn/VEIWW+sSxF4
	qN452DaoSLA9UK9Dzql8jnO0DQMziuYgto+DhCtDTIBf4Vm8L6IOYeP4Ot7khaWVfKe2ia5
	uzijZuJsMIk5jctHPUv0zzpY9wfkSD0pveHuRFSCd7k2kUluaQpkOdcEeIFhBFuLgblIfC3
	FO0u7wFdRNGkU5hmm9k0OZ3eFhMjdF7dM7iStI8YbL9AURW3ik8OpWmhIq2f+p3kR2QMlX9
	aTUbwKT0AEN/IsjbukIn/Z3U2HIa3HpTbXw0LLHc/D6dFt9xwQ3mBKxAZjb7EuURcC7kqlw
	lXEvps2C1hpwiSBX0JClO6Vg1n7gLMwGfWEsqNYUBIpQAQX+8HuLop4IoOQjRM4Cv1GBMxC
	1xqchuad5NRtamAM95ySTQp6RFWj6EE1drq2p9UhRf2OMmGvyJGBVwjyztJAIeeN4j2dNyu
	LYRR6iyteffBgtC3wDQHN1OkNdvKEDlHrwAsc1PY5GTqYqPcFdylZc0WPXhp2DP1HlHaK+J
	iC905FZ60dJQ1eVNlXWVKzM4FQ3wZZyjPiCY21gCNE2ddcqxTz9pEmGvKFGAyjteEQtCfH8
	/3bm4vqyjOXeJe1XCPQJicSQMuCtAU/aUsGkowedKzNdWVb98vhJv0uAuJyfhHsyBbK0HaJ
	45FFexkNu2nFWunc1kmz/VRFUaVWdgDX7keeVFA7LJh3opcPNTlxYY2ifvS/1r+Idxddx/U
	SlrNtXq4uwaKIqIqRYZ/NZzojSX8OEgXbJJYrc9mcqa8jbMsCqNL8DLpjhnzJCjOZSmSuv+
	Tiu9EcZUM7+/iJdDnqnf+OJjQjqJnb+L8GcO6TbMEo+T6KJZMWs1Ddfrnj7i8W1PVrnL+uy
	u8nEm5E35dK1VzSdQfobUy4tSt9TtbYSyclZ7fAc1XWJMaZSDXJOoZXdF+9vuUD0U1eZYhj
	lJV9xijEWK1QeeTHfiiBQkawJFez3MOa9uMJlqCIF35QtGay8ZEDVq66Kw+fGWuxaGwVjeg
	ZVQouuXRDA/BXGgNWYGhIN4HkSeeZ18RrWHFdJ/A==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On 11/10/2025 04.44, Harshit Mogalapalli wrote:
> When devm_request_region(0 fails to get a region regrion would be NULL
> and devm_hwmon_device_register_with_info() fails, best to propagate
> the hwmon dev to PTR_ERR() as opposed to region.
> 
> Fixes: 0ab88e239439 ("hwmon: add GPD devices sensor driver")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is based on static analysis with Smatch, only compile tested.
> ---
>  drivers/hwmon/gpd-fan.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/gpd-fan.c b/drivers/hwmon/gpd-fan.c
> index eebe39ef9677..321794807e8d 100644
> --- a/drivers/hwmon/gpd-fan.c
> +++ b/drivers/hwmon/gpd-fan.c
> @@ -621,8 +621,8 @@ static int gpd_fan_probe(struct platform_device *pdev)
>  
>  	region = devm_request_region(dev, res->start,
>  				     resource_size(res), DRIVER_NAME);
> -	if (IS_ERR(region))
> -		return dev_err_probe(dev, PTR_ERR(region),
> +	if (!region)
> +		return dev_err_probe(dev, -EBUSY,
>  				     "Failed to request region\n");
>  
>  	hwdev = devm_hwmon_device_register_with_info(dev,
> @@ -631,7 +631,7 @@ static int gpd_fan_probe(struct platform_device *pdev)
>  						     &gpd_fan_chip_info,
>  						     NULL);
>  	if (IS_ERR(hwdev))
> -		return dev_err_probe(dev, PTR_ERR(region),
> +		return dev_err_probe(dev, PTR_ERR(hwdev),
>  				     "Failed to register hwmon device\n");
>  
>  	return 0;

Reviewed-by: Cryolitia PukNgae <cryolitia@uniontech.com>

thx

Best regards
Cryolitia PukNgae



