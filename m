Return-Path: <linux-kernel+bounces-834271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA12EBA450E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98FA97A8890
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9454B1E5701;
	Fri, 26 Sep 2025 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQtGLSdw"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6046D16132F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758898701; cv=none; b=u20tF9rJ5x3yeXZP37fUA41asR5TaXbFkSaHrPWqONXkxKW9MhEouHyiuWmi79IByX21sxJqkZFzyL2/WpNpN2z3K3tjgoofeHJy7HLUpD/0vFNm6sotwHTDuYc4s1ST+BGO9LE/b27v7XwLVldzqVGc4SydHuPC20r0mvqr3jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758898701; c=relaxed/simple;
	bh=UX6S13400E2A2JYETUL24TlU0AW37E0wpTBHJD9VVEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D40bdt6bjik9MWM3Cq/sK1PLl/DHId2o6X3DokzAjsVupaWpaxGOq8Qy5GPXA1QxJ6Rm7i8YjxCD36ufufo66gE9EwShHpsmc0Ya14SakUwfLZumZRnioHLNLXdknBeVd7iD68cWI0lBUalVhMBM+t1kCwxzWpDOrvPOK5KESfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQtGLSdw; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3fa528f127fso1715330f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758898698; x=1759503498; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RG2t1x6d4pDg1biSV0ixz6bcC0WhKnoyTJ8dmqzmho4=;
        b=bQtGLSdwazpaRM67DUOZDVEynfWt0kzZqvwT/HWOMG7jpbGujEkSInEK0Xotek14fE
         W+5ex0SsUcYL8l1Vp/9IvaxmW4fD97VisCN6kRBE4dfCsA7CAOjTLTlprEV14Ob2/D5V
         2CqE9txu48S+EwUhnd03Nu5neCwJIQBfpTwv6nEZMIHq4ZhruDPkQraBIkqx8R8S7mVb
         9iWULs17/YSDX0i0iEIVScDLURFRlevEXoyKhUUYNEDno/UUcjtNwAcHDeDAwVAuxKg/
         Fa/m/+JrDVKNg5pIs3114o2SeIOlLunSO8AEMXdem+fR5VPylX+y6rJ3IMqasUHLNbC4
         kXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758898698; x=1759503498;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RG2t1x6d4pDg1biSV0ixz6bcC0WhKnoyTJ8dmqzmho4=;
        b=p810WP+2hEnSj6tJ1/YB2x3Fp9+99tRwqi2HxhyPK+rmLMDBsWIlwM4BbuP+vIElRs
         jyQyGQn/qHcel3/RIw8B2mvWUnxMN892HHuDR1ucqALGCodxp7RbS+XB7aeH6TdIwZu+
         M9scQ20UyfO70aeBAz/L9nb55u5ps0Namg7fRMwdl3Pl0urXgB6/IXx4gJ0+u6xGgqf7
         Y64dT3MkuBZ95gHscCCzNkysdHR4okLe5nLT+0xlUie9gfcMQ1PPh0v7rhX4yXPYpBXe
         A63CQ2U5/LY+bho9aRPJqaTOJP9nPG0ZPRIoZVanv+WUvPQ1JrK32ROWAqUuSHrCEPFP
         g6Qw==
X-Gm-Message-State: AOJu0YyzSFXcb5RTgzpTpASL+GgdtqzvnTwWbOIEeXvdVTeGU4WAq+uo
	Uwno2j0Hjz6IsJx7vMl3ptNCvFC0s01uj7KXtf/7mINEyFFd/g59qRmx
X-Gm-Gg: ASbGncuMB5cg7eIFNgl/DILxRe6YJ265O9uVd163Ca7B1RmNPdc4r8GNqRvZK+/2VqK
	o8KJq28T5h/o6QeFNTT5NW4P7RNr9cNX2bpqfq9Z6ovlPu9648UWJM5zwhh4hFPqnf4D+QDnnQv
	+4SF78QFI84B3CxvgOn5jsKGb61HbhXgD7hH89nPgRLhECJLiAl3Hm5RlnbLiuDR/BzTESpKvwD
	8umz59XyzHe6aWn18AUmx9EK1atshRbdXWxCm45hMvi9JQ5ij+5D0udk77O+2mXow1ZLQkOh8eA
	qOPv5K/9Z2EPZFBU8cab9HbLzHtTB7BrChFR9+K8MzsYUBFFmv/oHywZIcP6ygFMatOoGweSTCd
	jN5YMTkznIxTbxRQXRw7UnuOtXJb4etsBAOmEdpuifMYBE7xXdyH/hYQY13yuxBhGg0g=
X-Google-Smtp-Source: AGHT+IEw1Z3KjtLqt9s22Qg/dV2zhutzBnyhWYwXL0GgMWaC0SCBNsQXtHikROzRnh/0Y3BVcQfpmw==
X-Received: by 2002:a05:6000:2681:b0:3e9:4fe4:2621 with SMTP id ffacd0b85a97d-40f60df5f48mr6494903f8f.7.1758898697361;
        Fri, 26 Sep 2025 07:58:17 -0700 (PDT)
Received: from antoni-VivoBook-ASUSLaptop-X512FAY-K512FA ([78.209.249.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb729sm7095410f8f.6.2025.09.26.07.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 07:58:16 -0700 (PDT)
Date: Fri, 26 Sep 2025 16:57:53 +0200
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux@roeck-us.net,
	rodrigo.gobbi.7@gmail.com, naresh.solanki@9elements.com,
	michal.simek@amd.com, grantpeltier93@gmail.com,
	farouk.bouabid@cherry.de, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 4/4] iio: mpl3115: add support for sampling frequency
Message-ID: <20250926145753.kitrogfvssnt5rim@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
References: <20250925204538.63723-1-apokusinski01@gmail.com>
 <20250925204538.63723-5-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250925204538.63723-5-apokusinski01@gmail.com>

On Thu, Sep 25, 2025 at 10:45:38PM +0200, Antoni Pokusinski wrote:
> When the device is in ACTIVE mode the temperature and pressure measurements
> are collected with a frequency determined by the ST[3:0] bits of CTRL_REG2
> register.
> 
> Reviewed-by: Nuno Sá <nuno.sa@analog.com>
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> ---
>  drivers/iio/pressure/mpl3115.c | 81 ++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
> index 13c8b338a15e..b854732e61cb 100644
> --- a/drivers/iio/pressure/mpl3115.c
> +++ b/drivers/iio/pressure/mpl3115.c
> @@ -30,6 +30,7 @@

The errors are due to missing include of bitfield.h, will add it in v3

>  #define MPL3115_INT_SOURCE 0x12
>  #define MPL3115_PT_DATA_CFG 0x13
>  #define MPL3115_CTRL_REG1 0x26
> +#define MPL3115_CTRL_REG2 0x27
>  #define MPL3115_CTRL_REG3 0x28
>  #define MPL3115_CTRL_REG4 0x29
>  #define MPL3115_CTRL_REG5 0x2a
> @@ -48,6 +49,8 @@
> 2.25.1
> 

