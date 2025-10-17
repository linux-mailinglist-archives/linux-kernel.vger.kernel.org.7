Return-Path: <linux-kernel+bounces-857777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 564B3BE7EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71716506CEF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3CA2D661D;
	Fri, 17 Oct 2025 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y+psuXfM"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBC32DAFD8
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695006; cv=none; b=EzecJ4DlMSwr68LH40obsBZ6G/sye6nC7pmtEFoZrXpKunRNlKuVAIyWbE8s38R2V5uEnusOn2YZQCMvEjONzJxKDOvEMpr3PvWIrZzdSJZ6yj0lfdwJsXtgAB8DZ4lYk6/VFkHoCWGfAuYS8YayrLup5Krl/1l03dYeMBB2Vr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695006; c=relaxed/simple;
	bh=6qR0NuRYQ+bd1nXrohwHgTHeB2izojcTE3yTCQT3Hh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzBtpj2MDS0ri4zisSd8+RZNwy0xlAmXP7siEvr/+VU+Z7OSOQ059a5GhlwX8FbmSDPB/JwxScxmL+Uwh/iQ5aEbqhMQMJfxpLWIQd4iAEp47hZk3/cxsUq6yarK9ualws9W4/U0lSZI5VCblxIrsFO1IbFx23/rPpjfRjA+4bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y+psuXfM; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-591b99cb0c4so278415e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 02:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760695002; x=1761299802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GXi6Ax4xUuc/O76MAiPOqKbogCxizNvxptAHOFcxUM=;
        b=y+psuXfMNZTy3F5P5tY/hqQD0JdwzSa3bFPkHJlXsbGGwMxd/LSgb6moP8kPn2DpnS
         BrZQWjpoGsmKKBmeh1e03d4YByuK6VcnQPqCq2MpA0cHRL62u7d6Z6qy1Ly9NwgenjY4
         viW8d15p4wQP1LdyX4VfAs01j0kUyA9xOThB8tYisZpWsvsYGeTeQF6LGDyn6jR3LhvE
         eG3LeC9eDLA1ujeHLDM29LmqDudiBeKm60XxXlB5FEDCmkBF3StH6kqXh5FbipJb3BY+
         3OTTYYNtE1fcIRcQKqGtPFROhjcnVabzyQ2Os3URfwePpKaFIwga89L+Vc6iK8kw/o1H
         bbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760695002; x=1761299802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2GXi6Ax4xUuc/O76MAiPOqKbogCxizNvxptAHOFcxUM=;
        b=tAAFt8yTDUrid6+OUsdhfx6LhmUNvLKMbKt7tCsXJybRpQg7ZXZ3v2wqicw09cCX/E
         /U4d+cPXEO837L0DAyLyRj/soRq1j2KKSfwXvVA954e36Qr4XvxfuetVD2VrFAyUIsa1
         WGGJzJILEAMcfkWKCtJiOq+GA/mOCTcWZYCxPdlDrFOEh/XCuws2HoQeeTUF9+ZIEVc4
         c9NHl90bRoCW3XhQk2tQT+zPP/3Aw8rR6CINdcO3ijdv8DTy/02tzhYPlFOm0pAT6qYt
         I7+aJsbmTVxxnRQAD+sJKvpULmfhcLM4cEnllcQkVeZBJxvYh38ahzEzSXewUsUV2qDa
         X79w==
X-Forwarded-Encrypted: i=1; AJvYcCXoUFS0tbBU6YiZXhBimWxivZdUpqkOaqrA0gavlXnvqYtwh/wS9UgxdE24BEuELWEz5TQ+68JNC3id7Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8B0ycPPLB1UEH9PQNgoFK1OVRnSPHcu8AwJBOy5eG/cUb/yLe
	gEBM8CKcunAJugsBzTpMfWEdq6jIuLcO98kjuXBu9D24TsWbf7zajuRFowx+TJnxpGc=
X-Gm-Gg: ASbGncu+EL9l9+ii9DsNFBzrhWlpNXXvNYVyCCIayJOeiXRfrfr5fd8eoTBUNPRf6j/
	9Dk8Fja/21wJ2myIoVoXyfYgMQPq1L/yXgFbytsfQBMEgDttWDaa32j4rKCFBzcx31CvO3R1az7
	SAhIpkn1tSRgbcQkTbqVRbAVUq01yx9ibqAS+uh1SGAEZ6M7QM+In4lFyVt7ybnQx6j6ch4Cq3V
	w8/msA14i0muIdksmWvzN9dpwuT5FT/SimRv5NzOkpBO66Jv6/tdfDSENT/7fUgiJkLv227BmKR
	PgHw98+T/mA8QHDYmVDf2fpeI+5nv4um36053DGa08TPJwtCoCTtSlFYBj/1PPwK1U0dnoemOD4
	oEGVTB3VUCTjjYRyYN6yEDlTP2MXQnMC6iB0c1DIInfnPgKTuE4YGkJoS39nWgJyqVYtWT1Mvk8
	ZKU/L+X+vbp2i0r98OhRY24FdpD5Hbqqped5Ei2c0GDxxZ1VCJ10LMZ/E=
X-Google-Smtp-Source: AGHT+IGAZ5CYugbUgk6P/NUNsSpjV1iSJD9ABIKrrzr/2GQtBVeEEAoj0LM3E1ItWcJjo0+VtHVCpA==
X-Received: by 2002:a05:6512:684:b0:585:805b:e3b0 with SMTP id 2adb3069b0e04-591d85ae86fmr686720e87.9.1760695002167;
        Fri, 17 Oct 2025 02:56:42 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e688dsm7747393e87.13.2025.10.17.02.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 02:56:40 -0700 (PDT)
Message-ID: <5cd4ad76-8aa1-42f8-81f7-e5fcc895f693@linaro.org>
Date: Fri, 17 Oct 2025 12:56:33 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: qcom: camss: drop unused module alias
To: Johan Hovold <johan@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>,
 Bryan ODonoghue <bryan.odonoghue@linaro.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251017060435.8524-1-johan@kernel.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20251017060435.8524-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/25 09:04, Johan Hovold wrote:
> The driver has never supported anything but OF probing so drop the
> unused platform module alias.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   drivers/media/platform/qcom/camss/camss.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index d9d770e5e7c6..c93aeeb5ab20 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -4545,7 +4545,6 @@ static struct platform_driver qcom_camss_driver = {
>   
>   module_platform_driver(qcom_camss_driver);
>   
> -MODULE_ALIAS("platform:qcom-camss");
>   MODULE_DESCRIPTION("Qualcomm Camera Subsystem driver");
>   MODULE_AUTHOR("Todor Tomov <todor.tomov@linaro.org>");
>   MODULE_LICENSE("GPL v2");

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir

