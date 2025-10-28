Return-Path: <linux-kernel+bounces-874274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC03C15F0C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930E33BCEA0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099CA284889;
	Tue, 28 Oct 2025 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dsCz8yYc"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B0828D8E8
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761669723; cv=none; b=gMg/Rbgiao4AS0/GrV0zqJWRXm+pQOo0EzhAPg/oKmMdOZeSuN5nP80PMwRippuYW+gnQsLyoHtKv54yIi6QEgmKnwz773Nd5oejZCgmAheF/pIUpfHuktKkoNyvCcx3y6KfDlUgoHUmR74wK+gDqNWBlCx8Ncea+uSESLx3yyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761669723; c=relaxed/simple;
	bh=Uf7YRleoZ8waDLnTeCs4F/ntVYNVy3X0xp3jtNQa1cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mnnd0JUXEte/Ib+47AqXgLRpuap7YSs7oaslabMRkD9U4ZoIrMUBdd6/fsKHGFaXsdBrOEVAsuHeKVfNEh+i+3IFHLWNrepmZGNWN8N0BTgncQevbUrllmMrxemDJLPZvz9jlJktqgqOOnYEfSjuqlpNc49kAb8ouTZLIpPH0ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dsCz8yYc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so62210575e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761669720; x=1762274520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vhlYsnjrb8qWY7F5kdEd5kcGIAJVu2xCqJg/0zS6j5A=;
        b=dsCz8yYce4z6QUy5jbLUc4Q2DctIUnaYR3zPbDpom0lCSx00etgB2zgUlqVpRVW3+G
         Y4FdpK4qxF6UVAN6TYFZ9PVdP4jN3SRNDesyweNmVsSpq5zK003+IAkjEson5HW0MF9y
         OEx9ocDE8gM/B6lPsgUPWXvG1yOLNQYXGEKfi6/6JC1wqOSxqJIoSLZChLrW96blH9Hl
         Ckb3IJRwTSVbmGLU+kCbezZCm844n4QytM1RtrFSrEMd5KiUHp5OLbuQWlzX5LCPpqIc
         /Th0+zsM33ZSgxG1H8VVvIZ0nWvWM6wcEReYRB+jK3GVijAdUybMQcYqXAdmljd5JVP+
         lEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761669720; x=1762274520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhlYsnjrb8qWY7F5kdEd5kcGIAJVu2xCqJg/0zS6j5A=;
        b=cqKclw/5s0PlOePs9ALIZqBGP2ThUE5z13FRJWeA3Dq/nIVgx0y6mjbMAmC/AptNb7
         Eyi7LdJLYqGpYaqeToe3yygkhrGpAtBHP+DabjT1x6qAhJmMZRqadk1wvmCYypkPI5MO
         tQeSQZWNbueu8DsuLmBr3WrsQtmyvbGSGqYh9wLX8Rv9gBMm2iM2wTjms8bDQuKHJcZp
         byOoTHfoDLCwBlZe1nH/VkNrMd+4XOvuk4OQy8cGpysfrQiMyo3lX+PPUy6iZYH69Pmk
         0clcyQqRz+FBm4SdGgit7OAU1JmRvIPE55aUXnLuZ193kj7309PW+9MkIxKhmKTSdP+v
         IBRw==
X-Forwarded-Encrypted: i=1; AJvYcCWWFGFLUGDVNFeOyPpcz8uDoPUPI3GN7cb8i/YZW/Pg3/TvhG7UD3Rk0t4emd853ezcZsuLwT3DOk+3N/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaf9ejtbsYOSw6x0IXtS/9QiQcI6+VYq/2CruO8648YTovzjxb
	KxVTaHiYu60h6z6EAI3KhoCxLfnVtoxayPuNblkrqNMJ5eIKcWUx93lHOTu7g5HNvFU=
X-Gm-Gg: ASbGncvAivK4jYvHYpvbmCUfapWZiX3Lm8J5/05wykzFyqmMytou0bLniwajFFnvDyE
	EZPYstzDB+HJ7+8mfFnx/ocIOhz+ZBAhu9djZXyWgtGG3AIVyGrDeCNNNfJk11NHFy6DVhcp6FD
	GebJ1JsuYtiKLCp5itlJJlJ9ePkJPq2vGJGcr73Mi8FkErcPw56dxoKtwvQScN8paCHmfxp+e5h
	ohZgR3nz5t6ZZ/yLZtDGAvNatBDEtYRo7olMRYW9kB+/gS/0orFFIlvBkA2dB5mshx/dT1zY1MJ
	q3kG9slPFDVgvOErRSE9YbP0574P1mIpBupqDlAcsuPlOKRCMLJmHxjO3IYX5+emsj2Z4mf1uKK
	5kllippLCSb09I/EBvj6qgKNr2stwfiAJfRHI+O+H4M6sEBtN8+afn25MLJvbUjxWlpQO/45o
X-Google-Smtp-Source: AGHT+IH7rrRXNKsSpeh9VK0VCQyJohBZG1DTw0Ze0pbjGzldvRlBrP62vUkIJ2C7Cpq9y6KonRG24A==
X-Received: by 2002:a05:600c:4e0e:b0:475:dd7f:f6cd with SMTP id 5b1f17b1804b1-4771e1f1181mr1161625e9.35.1761669719903;
        Tue, 28 Oct 2025 09:41:59 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3ace25sm265145e9.9.2025.10.28.09.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 09:41:59 -0700 (PDT)
Date: Tue, 28 Oct 2025 18:41:57 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: qcom: qcom,pmic-glink: Document Glymur
 compatible
Message-ID: <xuadnvmn3itiznukzxw3kbe6lg3kk4p3fvuz4ozxp7etllub3h@6knqgzz7popd>
References: <20251028-bindings-pmic-glink-glymur-v1-1-f76f00161f46@linaro.org>
 <p4l2d4mow3my5zzgjieqxldv7dybk7qgfx2yshlji5svaad46s@xprmpn2s6na2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p4l2d4mow3my5zzgjieqxldv7dybk7qgfx2yshlji5svaad46s@xprmpn2s6na2>

On 25-10-28 09:53:54, Bjorn Andersson wrote:
> On Tue, Oct 28, 2025 at 03:59:49PM +0200, Abel Vesa wrote:
> > Document the Glymur compatible used to describe the pmic glink on
> > this SoC.
> > 
> 
> This has been posted multiple times already:
> https://lore.kernel.org/all/20251017003033.268567-2-anjelique.melendez@oss.qualcomm.com/
> https://lore.kernel.org/all/20251027212250.3847537-2-anjelique.melendez@oss.qualcomm.com/
> 

Hm, my bad then.

