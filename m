Return-Path: <linux-kernel+bounces-830889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF220B9ACC9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F78189C40E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488BC31352B;
	Wed, 24 Sep 2025 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl16a+GB"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E1E7261D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758729633; cv=none; b=rj3lACQpdGJZdWFk1SUFMvHXrwOooY+yCA408ZgnnLPrRXukeCzXl3XDA96XMKJYap9/t29ABS6E4ocqJ3Y57gmUzzqEILQHbr6nMALp49m14uvGVKIe3gVQvuVagJm4rJY+24I19Tjmu/JFscFe0TMRUKrcxbsyJlelE1j9ndA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758729633; c=relaxed/simple;
	bh=vldrG3DCeNRjE0BlLdRWKYuZIHower+u3hHn+TSIV98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7vZn8xG1Ny0fUXHyTu3K+3qIfV7zPsZVrhimqSzdGH8jrfrhVCsp52WGbGAz60qe5ygWYSVseHRXPlQjC4+oAksjcZ9/z1yO84B2Dep5nge4M8kxTbHLCUjbyXKyqC5qYTc/mkiEblrBfhKtPf/owOowvJ/AmvjWqephp4gTcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nl16a+GB; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b555ab7fabaso2590614a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758729631; x=1759334431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/eQZQr/FlrHFqBmnzi43q5wN7esytT7U9mYDKA0Bws=;
        b=Nl16a+GBe5nIxrowTVguBXGovZeuinGypiJQadH8OBO97ToiNLq1OBnChf9Qi90X9v
         YyZsV/g7ELyU6ykAlJ0haVmY/rJ4nD7dUCKpH0D3fzT52ZwZPgvkRs8OH6v5kAtaGDg3
         iDvJXZ4zTblSptnt6quD8KRVJ9asjEUohc8PddZtnnM8KPdRYTbf381Et5aeA2m8PgxA
         b3aleB9ecDxJgDVPFKpIn4AsDced+fuuaIQZ20DtTXViTfhS+oHj9S5xUSCQsUleF7G5
         Ogrvm+++/htSJMFc+2xm8cz6DrnGXdDJaP+CI9KDiZftgVZi4o13c8WJx2tQ7/I+qTy6
         x70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758729631; x=1759334431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/eQZQr/FlrHFqBmnzi43q5wN7esytT7U9mYDKA0Bws=;
        b=PPSzc5qMWSzlZYcltdnXXKOjVnbh3W4RBJic20VPK3n5xKnHIBPjitq4CDgJ+drFcD
         hr6EsZ1WkPRPDcG/B/hlhqxlT7xx0H8hZxzh0emBuOntQa1ATuc+FpprnwGGnlu3ppkr
         vq8tpOC0RaAquV4FE/DekDEH4D/srIbglM06J31YfoShL1jFpXNyydnK7RRNV2mg698E
         d/gdut0Jqw8wHI64Z7TOKusWmxzz2tXFDppE9veZPN8htVJ/o/eEk/mT+E9dbYFMv9YT
         ZAUkn7myx7lSIQPV8Ct20kVMZ5/jN0nucHSQg6Dv3MlKAghSTWsospynZVWntmmv705V
         YUPA==
X-Forwarded-Encrypted: i=1; AJvYcCVE8MmOvWK7McfxzS4lHv70dNT+3XAprCYbuko2ephS6SlqgKHCzjqEANlTEy9dOMF8CH5HNpxP1onm/h4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBb9GgTG2udl/THgMdPr0jSa0g1H8HgKj+8G+qXL2KAzRY1cZz
	2NLeatejrrmGAp1eghukp3Z29CZ0A8Y3VF6YP9pePBLUfh+gkH7hiw51
X-Gm-Gg: ASbGncszTGa6AbTgJZOxlS0TPpQ2gdvVIpwVDwsPFlyWCcwaj0J1AYIdvuH7YWwloEC
	hiP6yzEzHGfdFDJaXBEHdPJcVELP3+uaNy3jn3UW4ARCHDZapdLLFjBPbxUforL3/8zLirlMZgi
	6ziSPuS6M6cRxjJtqQaNtH4OhkOuzRykpzR3IYX11SfahzOdkrIDvXaDxIZ0M0LpM5K3tzhzIhT
	DBYxkt45APwCYwjnEHl1ZqW4zVyuaezWqsTxpzV4I6gQ77Kt0+hsboewo7BTxS1La13quol0BpV
	PiTMNOo8O8kUIMghQhLOSiUB+QIMFKEn7WKgaITYyLB1kZos1pleb/Dhw4dNnNXMUk7Xzmg4y+5
	Rr7jWPyfMhgjPTXooRmR6D6fRtIq7w2n8m9o=
X-Google-Smtp-Source: AGHT+IHh6nEKuJB+/U1aI4KfR/nSkf414wZmo0pvYnpISYF821fu02/TzRKwO0iL6xcTPglHzJx6Xw==
X-Received: by 2002:a17:903:1a6f:b0:272:f9c3:31fa with SMTP id d9443c01a7336-27ed49b8e31mr2949535ad.9.1758729629711;
        Wed, 24 Sep 2025 09:00:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053201sm196264675ad.17.2025.09.24.09.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 09:00:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 24 Sep 2025 09:00:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Michael Walle <mwalle@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean Delvare <jdelvare@suse.com>, Lee Jones <lee@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Andrew Davis <afd@ti.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 4/7] dt-bindings: hwmon: sl28cpld: add sa67mcu
 compatible
Message-ID: <bffc6119-8623-47a7-aa47-40ffeb6ec09a@roeck-us.net>
References: <20250912120745.2295115-1-mwalle@kernel.org>
 <20250912120745.2295115-5-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912120745.2295115-5-mwalle@kernel.org>

On Fri, Sep 12, 2025 at 02:07:42PM +0200, Michael Walle wrote:
> The Kontron SMARC-sAM67 module features an on-board house keeping uC.
> It is designed to be compatible with the older sl28cpld implementation,
> but has different sensors, like voltage and temperature monitoring. Add
> a new compatible for that board.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied.

Guenter

