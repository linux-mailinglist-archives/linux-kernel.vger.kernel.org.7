Return-Path: <linux-kernel+bounces-775082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 561F6B2BB11
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60727682930
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D4D310629;
	Tue, 19 Aug 2025 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gj9vDIEC"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D76284891;
	Tue, 19 Aug 2025 07:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755589737; cv=none; b=ZNZ1VgcVEEvHWzc+9d1wtzCs+eLCRpjG+S9hXHw/M8nrleJ7X+u+N/d5NXOMXsKOh0KZ5QYIzPBiNj0zoCVaTmF7ibE9VfDXGyrN+SI/Rd7CO/o4nzr0v9RNVXHJOtlXcHul7DEDyhMg3eYHo2Cy1Pg2yfmHF8ob6BWw9MPiSIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755589737; c=relaxed/simple;
	bh=Qp0PoTzwfuUghzu0np/WZu53zNwZLmmTS9kXb8pX9b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJDpdIVcAh3UGRSXiXpaG5d9Z7Y0vTV366jj8tAy+B3j/0kNFnRa4Kd4Cq10CYD+xGyJPh41MtjwqI9C45wyz2ewU2W7BFoE6LA5q9SLTKYA5Ig+uteIaD36y9qnL9LHuyRHO+TVuel54Dv9u0MCCNSeDt6Y4v38ICkezsbAinc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gj9vDIEC; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b47174beb13so3592675a12.2;
        Tue, 19 Aug 2025 00:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755589735; x=1756194535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+ht79aZIMlN7H9jxDjI1MTRwr0PcN1XBiR81e8sSRJw=;
        b=gj9vDIEC8ZZTz4dI8DxCDQv6k3hLkpzG6ug5Qlhl+13sYQFxPBeI5H+PZxdGiRV0CH
         sRQtqGCfb9Tv70w25ZVYpN/6xmuMjodLNoGCRAVMUycizi5v2nmpLt7LBMdev3PguqDa
         SL80ng9yBM4oWKwRsZeE1OuYjq7W1yET2ed9WGiw/YuPDfCeHIFqM7zGDddTLGsHiMFE
         Hzk1+uGt7wKYXeWTjFeZ4vXZjmZeHqcrM9peQ0hA6G89ct27b6c7S5NTf6raEiZnVl/L
         WW1JyM/iRbf/8P3aaciF8//ccNiVdMn/uoKr720yggt+fjP2qMP33D78NRoPQEkHzLUM
         /sZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755589735; x=1756194535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ht79aZIMlN7H9jxDjI1MTRwr0PcN1XBiR81e8sSRJw=;
        b=XL8wA/EAh7bSlUE3dOf7REOIxx/TkEHdzPzl6TfIYicTWJvv1zKZTSCqbIQtTvsQc+
         yJVKLhX6Ysy1CIo0k31i82QBrDkbDhRksa60FZTzkGAUJ6xCoNv5/prxW+aUqoRfwjZv
         z1pd5LZ/FubHjsKMrH4JLztvOABvF12L1pr25tVV3rni8usZV/LIwxPEVkqxluVPB63H
         c4AWVhy3ePh4aaACuaPL2MhPODua5/NJ75ImGfKik0iYkiT5Ue1ikLFP3saWxYDYNJTv
         QJUD21X8XDYcxeVBkkYqWrsD3NIwuQ1KYywLXs0BFaFHiVc+oahr83MH1Vi3mR7VIKuW
         W9SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaFHLfqwGaBKUw8y+UUm3iWk+75qH1veXViRBFL2M1bjazoGrMUQWTHqvxS6P7OWnuknqGftbdI/ko@vger.kernel.org, AJvYcCX2SAKSpIUkHwtgaJo/tFMhnQipZazj1UwRb61USnOMq2YTolpEwrioedlghmfS3tdtFniV6NqkV/L8ZFho@vger.kernel.org
X-Gm-Message-State: AOJu0YxjfZRo4x1MTjM4k5eXUIYyVTGfFIKWcjEpYkQt8ogGbQBAGolu
	gG0Z0A5mM2KE4pQwXcz0xp2sLF1jTd5/AziZqpas1ztY7nS2zUlBnZaEgQbndB+a
X-Gm-Gg: ASbGncuMtao+vX4RHrmow+lC0HY74ptcHh4vtovC0E7tfFCCMHW/H6XY4OHtdddzhtR
	E41mBYcT1EOLR868qXs72nv8A3hMxAWVtNaicJ9/VmzKAYoRbyUkiwyBJshImkI7bf+3Za8Bw+e
	V2qDl8VcaT9acTwaJEqNFFzuRwlN93axAzZdw6tXqomLEkjITflur9gF92uqGqnlpE4Bl64x/lD
	QI3EyTqjf4I3hgldbEcomNN+BLKRN1JibYFtI3ZsZHnqiXuiD/AtZBKQOYRI7gx+4Cwo8FmERYU
	fDRLhKAtesEaG0NjBRS6lqzntisGgzpAOrevNe+SSFdIrZNLH0e2n/rDZgt5SH7VFPJFyLkUgk8
	xcyuu+XdoFaX2/5k=
X-Google-Smtp-Source: AGHT+IFyS1pRC/nilFKVPJJNIWYZ8E/oqWs0FiyBi5MrOvkqeJATfICeqlfkAYPlPjxjgr2XEtay5g==
X-Received: by 2002:a05:6a20:3d89:b0:23d:e568:e5ad with SMTP id adf61e73a8af0-2430d4753c4mr2069420637.28.1755589735214;
        Tue, 19 Aug 2025 00:48:55 -0700 (PDT)
Received: from anyang ([106.250.177.234])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d122ad7sm1684649b3a.36.2025.08.19.00.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 00:48:54 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:48:50 +0900
From: Dongjin Kim <tobetter@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Change ethernet TXD timing delay
 value
Message-ID: <aKQsYndrYStGTfoL@anyang>
References: <20250819045018.2094282-1-tobetter@gmail.com>
 <380246b7-7e7a-4843-b82b-2e8d74e01ad5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <380246b7-7e7a-4843-b82b-2e8d74e01ad5@linaro.org>

On Tue, Aug 19, 2025 at 08:42:55AM +0200, Krzysztof Kozlowski wrote:
> On 19/08/2025 06:50, Dongjin Kim wrote:
> > Very poor network performance is observed on the ODROID-M1 Board
> > (REV 1.0 20220613) when running iperf3 (under 200Mbits/sec), and
> > this problem can be resolved after changing the value of TXD
> > timing to 0x35 from 0x4f.
> > 
> > Signed-off-by: Dongjin Kim <tobetter@gmail.com>
> > Change-Id: Idecd246e3fe93447b6e3e9b165d077d2050bbd75
> 
> 
> Please run scripts/checkpatch.pl on the patches and fix reported
> warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
> patches and (probably) fix more warnings. Some warnings can be ignored,
> especially from --strict run, but the code here looks like it needs a
> fix. Feel free to get in touch if the warning is not clear.

Thanks. I realized that I sent unmodified file that includes
"Change-Id:".

> 
> You CC-ed an address, which suggests you do not work on mainline kernel
> or you do not use get_maintainers.pl/b4/patman. Please rebase and always
> work on mainline or start using mentioned tools, so correct addresses
> will be used.

I've rebased to the master branch, so let me send the patch again.

> 
> Best regards,
> Krzysztof

