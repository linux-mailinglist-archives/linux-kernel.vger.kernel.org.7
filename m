Return-Path: <linux-kernel+bounces-854432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0D4BDE59A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A11C14E572C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0E6323417;
	Wed, 15 Oct 2025 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9PDrK/v"
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A62321F42
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760529459; cv=none; b=lSzl0lffcgSlzbyeHOkY8VCCv3WFCusdT5hZOyxWvS4YNIad7pV6ttVPDiCYrd4YHn+PQN1WMhvQQCXkRLj8FMSJ8SUPdLMxH40fYGBEiAuxscUc+Bhel7OZ2smw9eP4odp/J68Gz4cnhZTVsag/HUUqDNfB6oC66hOV4vrdQpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760529459; c=relaxed/simple;
	bh=e6nUalP9hfTJgsbidLIuHQleVlwtT+pTzZf78d6vMo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JWT40F0hCOhEeGcMr1q4i9zrItgH2OThT2CzjSa2Cgo0+WNWBe1PuKgxaXolxTo41yEoTdjvqCv2LRa5fPrbroA9jfDhlSu6PNvcDlddgK6sh05IukqMkvtd51WdjfdGtiT29AKYfG0SEXwT2vI0cIpdL9R67I88hrILhdWal6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9PDrK/v; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63cf081f87fso4527630d50.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760529456; x=1761134256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieaWzRWGII3uqPa4WyCaS/MYjwfMUCH1mb2GlldqZ1k=;
        b=C9PDrK/vD5sfdAleE1YJqbiaZDCk3UKsiZsOMbaTVEo4p9TJcaUcF/iVUSjORcK05N
         uq9OYwDo93B5Me2AZZfkRLSNIgMD8c38jCbmXMmGf8J8pGal5D/47O2Q9ku5DEywZqwG
         OmXg4Yv1a5eizEVWwb7gHCJ9w8llHco7v9w3IfCX3OEEDskF4I664w9/GygTbbzZlj0c
         MraauNS2NeOujQpQJyTFM3412kqHaGAXayyE5wxPMWAPedomUGIVPr6w8O78jABSFzO2
         wHJUv9YltP6R4K/r2E61rQHqLYZZWmGi3Qy6x11f+NBcXm6IkpO0r2Ljk+oaeQ4GAI6K
         M5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760529456; x=1761134256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ieaWzRWGII3uqPa4WyCaS/MYjwfMUCH1mb2GlldqZ1k=;
        b=kKmwJJTYPyhX5qUdg1yaATjJM6hUhESBsMlWlX89ojLp3OCIPfr0PGQWmvByTCWVX4
         D1nCN4Mim0CWmhzF6FoEWv9f7GCsK7hcu57C9ya5HwRn+1yoEriLJqDz8YIueF9FbVrX
         WlLSuKUxy3Ul9Y7f3p2ngwzBYCJXYItVNiom8c0lkYyRp/tWzcr5XL9hx5/6GZePKAKW
         P1OtoLdehFRFowwDAg9xlJe2lHjgSYVJtrwkwyz+ZjI9iaTdtj7nUv93EGR1oBnyGvE6
         QaNr+Y04qOBKDqTdHxubTD11PUmyFAob8jjuXjZs6zgb0qR1hhUbTryBqApO+9NEqGHl
         LODA==
X-Forwarded-Encrypted: i=1; AJvYcCXo9d4bdh0KV7GiZHu6vMzjyfC+6C/MXGg51vhFDHNlz+6c69feUHJ6TgBhPgRZOETjkTQau1nV2DWBgvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwetnzzMX7ABG+5KEk/h4fHriHv1F2zhQTV/UcMijx52CO7MXkk
	QKEINv1PvNVgN0lyOx2EtSr3lmt6L8Ypx9VwIWFmAdPzgimaWwMO3R85HARMIk+XQ2tZzMwHfz/
	U+3IoVII6CgsfZMXyb4zy2RSKjbXh0n0=
X-Gm-Gg: ASbGncvvceTNCCPxfxeefugEAsbwlm7wDQql7qr90+dzPT9CYN26gJAOdhHfNM+Sgeb
	nZsQPNMs00s64MGZJiRhqQvD/peyCgRSCWohfWLMN+q6B3cyx/Bo0r1NxYJNg7ynamLn4r8ar4P
	dhnhzj7CrzZrOhgsmRYnEPJDJBXglkpB7gt6VfGRos2JmqsMEKtBbQw6vMqLwLXTMpGz78ho9lV
	F/pQj/D7BohXs3zH/FvhQrOyA==
X-Google-Smtp-Source: AGHT+IFNe9SeQx840UU/MTW2ly7whPTiSlZ0Fatcdl+zHeGnhTcfrwo2zlexd/EV4UoupspsKkcGV6yrEL5HlrHNkQM=
X-Received: by 2002:a53:ceca:0:b0:63c:f5a7:3ff with SMTP id
 956f58d0204a3-63cf5a709f6mr9503871d50.67.1760529456518; Wed, 15 Oct 2025
 04:57:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-st7920-v3-0-4f89d656fa03@gmail.com> <20251006-st7920-v3-1-4f89d656fa03@gmail.com>
 <bf207d35-3ca9-40a2-807a-0dbb0d1504de@kernel.org>
In-Reply-To: <bf207d35-3ca9-40a2-807a-0dbb0d1504de@kernel.org>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Wed, 15 Oct 2025 13:57:25 +0200
X-Gm-Features: AS18NWDRb-G3sUnj4rnpU7SKnuODhp_u2ZhjVPW2nZFhRMfdfCfjUZN2mnbd71w
Message-ID: <CABdCQ=O-WSt9f_cbwUhRw1uy5a-P3-dEcJfcq8Y8thDAzVuS9g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: display: sitronix,st7920: Add DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mar, 7 oct 2025 a las 11:12, Krzysztof Kozlowski
(<krzk@kernel.org>) escribi=C3=B3:
>
> On 07/10/2025 02:48, Iker Pedrosa wrote:
> > +
> > +properties:
> > +  compatible:
> > +    const: sitronix,st7920
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 600000
> > +
>
> Datasheet I found on the web clearly stats you have at least VDD and XRES=
ET.
>
> Your binding is still not complete (and I asked...), while it should be
> complete (See writing bindings doc).

Thanks for the information. You're correct; I'll add the two suggested
properties, XRESET and VDD, to the binding. I'll also implement the
XRESET handling in the driver.

I missed the XRESET pin because my testing setup was working without
it. For VDD, it's currently connected to the RPi's 5V output.

While other Sitronix display bindings in the kernel don't currently
define a supply property (running "git grep -i supply
Documentation/devicetree/bindings/display/sitronix*" confirmed this),
I agree it should be included for a complete binding. I'll define it
as a fixed-regulator in my display DT node.

>
>
> Best regards,
> Krzysztof

