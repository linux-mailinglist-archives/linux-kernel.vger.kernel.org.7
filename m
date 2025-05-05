Return-Path: <linux-kernel+bounces-632612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9972AA99AB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 18:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65FB87A24FA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 16:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00DF26B097;
	Mon,  5 May 2025 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NUJEhyGQ"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82696268682
	for <linux-kernel@vger.kernel.org>; Mon,  5 May 2025 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746463709; cv=none; b=KCLd1KcGhFIJoN+dkUesqyV6w/koAJs/0Zk+y2AN/q5X0CNEXhaXR+wP7Lq+y9y45tlwzi1ejlGSbGjWlUJkviOpzE1bPcIsqoVKcxirXSzagX2WrQ/1AYI3ARFCu85CMvzD1mEcdSusMiHOv93ulfQQyFin2EIqmHmqFCMKDBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746463709; c=relaxed/simple;
	bh=d/w1uLpQ2W4vbRq5UhqvNe4JuFB6ZDEyYHk1OIfpEqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbX886qrQkJlj8j669pLsdzERP+wcz8vO/9vNC6En/bCuT8iGaiRujCWpL9l5Zcpr88NsP+CMrBWwefuwEPem06fcdw8NsZKVI5Nvh+KkwdJZIkHoznrRKhvH2Z85/jlqXsgvPNjNobSu4th7N/miQbPN9jv7ZIQZTKcyZXtiyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NUJEhyGQ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7403f3ece96so6138201b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 May 2025 09:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746463706; x=1747068506; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jydswAFnXteQh1UU3QGXjNU3hWHc6hixoWxuLW3YU+Y=;
        b=NUJEhyGQBBoePJ8nFckLgad904tYAh3yKDPsPTjUVd7f+2IG/RTgFLpWf01/Lu2sSk
         OvC5dDjpFceIvjDNgSA31UgRinUaTWl74wdX/Ig/KvvYnADX0jdruzMKVDSFvCjt0e90
         UNv4LGj4zzL+glt3gycV/6xZm8uckjhkNc/+jP1vDbzNnQpgwnH8VTXOfweT/RjFqxFq
         9iCy6IwDcRJbMOQOzRgySHr7GpseVsvcJWfQhB8wkbam3RNEVqQRX+CuYb1fZGdSDC2S
         ZMGraRdSW7WvX4AJfETAY1Q5E2vErRqZZnPILThE29oSZJ0bt1C1SLpnLI5e510qQkIx
         VYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746463706; x=1747068506;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jydswAFnXteQh1UU3QGXjNU3hWHc6hixoWxuLW3YU+Y=;
        b=o7wxG2vmTLm5TpdI0HK3LLEk0vWyK2oESxKZV+ZDdg1eFqzMlEInif8J2f48QkQ2jo
         JDYyG5yJ3IIMbI9EgHQujgI2AmGRF38pVPWuOWpbAerrtT6b6PmOnUA3fmuTO84zh/Sp
         Wq1X1av7chjHdTP8CfovUG7LHWoEkVnM/OOitW4a9gkOIbfQbTrebajmTor0/ToTZRjV
         MchAKYKcl4izQKfv0Y3/CfhxRAFuEMDiw71/snXYgs1xbAZHJW1nahswFM0PkHKH08ZN
         SYKrPnka6Ghf9HN2xfiyRrN6CDbAEss0De30GZvv8OmYjD3p0gS5Uc4UFiuZSXnEeKuS
         qnHA==
X-Forwarded-Encrypted: i=1; AJvYcCWMXFDghIaUaSnipq2jM/woZ0LNlqErBk7DVbLfa2oGhV2CMkzJ2YX1qgxfGHSuo0YpvqbEsUMD/sH5xrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVMGBc7Zup+VAlXBsYSBM7QTp7+yzdelrM9h/XajEM6es6Q043
	cjinJ0LyDEMREzVz1/aaqnt3uLyx2D+TIvradFGpQJtnBVomO5+wt1IdRCB5PQ==
X-Gm-Gg: ASbGncv/7tczgdfAevf1TyT1mP8N87irpnaQR6mlhCFQquJVcZK327DY4xf2dWfEaP/
	Hbg/ZwSrI99SySnUHl8MpUqdTaqYeMoBzOyEHxw7sBkGDXzJTZU+w8OKk1lHcxfjw98hfM6yzn1
	zEW+lFHI6w3jISD4o0nwKJLcH5ZcZ7lAOd6vNlyvGM/aEO586KBXIr4rfD4ZVXREOFRVqM+wM6Q
	Q2KVyY18YxpirSslu654WJovjFcevEBT/I2ZFKDsDOXlegdbhEXXIBjxkO1otHUhitvC0hglt4F
	SF5Qo9hU6LIivLCR84Patr+8Q1osqT4qp2KOIZ9/bEOfl3SJJ5c=
X-Google-Smtp-Source: AGHT+IF0IGm6fDHGPK66O6bg5JTvgXJJb1FD4//3SnxAo7KjM8JdSqs+9ux0Ap+T+I2E+83jN9O/IA==
X-Received: by 2002:a05:6a00:4408:b0:736:3d7c:236c with SMTP id d2e1a72fcca58-7406f0d5d84mr11288854b3a.14.1746463706657;
        Mon, 05 May 2025 09:48:26 -0700 (PDT)
Received: from thinkpad ([120.60.48.235])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740590616ffsm7268130b3a.140.2025.05.05.09.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 09:48:26 -0700 (PDT)
Date: Mon, 5 May 2025 22:18:19 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/4] PCI: tegra: Drop unused remove callback
Message-ID: <gxbuvopbhum3v622gf4olzfspgihxt3dm4z3rsj4gquaabt2c4@peemxrxshjuu>
References: <20250505-pci-tegra-module-v4-0-088b552c4b1a@gmail.com>
 <20250505-pci-tegra-module-v4-4-088b552c4b1a@gmail.com>
 <idddypjxxtiie3tllfk47krcydlno4lnhbkik4wakekcyu7c2d@iurtu6bjzeey>
 <CALHNRZ88VaS6zmmnkQg_WrBVPjMT4e2uPUPEQUj8ARL1TieZPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALHNRZ88VaS6zmmnkQg_WrBVPjMT4e2uPUPEQUj8ARL1TieZPg@mail.gmail.com>

On Mon, May 05, 2025 at 11:43:26AM -0500, Aaron Kling wrote:
> On Mon, May 5, 2025 at 11:32 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Mon, May 05, 2025 at 09:59:01AM -0500, Aaron Kling via B4 Relay wrote:
> > > From: Aaron Kling <webgeek1234@gmail.com>
> > >
> > > Debugfs cleanup is moved to a new shutdown callback to ensure the
> > > debugfs nodes are properly cleaned up on shutdown and reboot.
> > >
> >
> > Both are separate changes. You should remove the .remove() callback in the
> > previous patch itself and add .shutdown() callback in this patch.
> >
> > And the shutdown callback should quiesce the device by putting it in L2/L3 state
> > and turn off the supplies. It is not intended to perform resource cleanup.
> 
> Then where would resource cleanup go?
> 

.remove(), but it is not useful here since the driver is not getting removed.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

