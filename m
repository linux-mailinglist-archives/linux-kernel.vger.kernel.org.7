Return-Path: <linux-kernel+bounces-878734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E84C215A5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A424B4EF016
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41122311C09;
	Thu, 30 Oct 2025 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZf5k1X9"
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E54030E82B
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843504; cv=none; b=BxkzY0tOJHarqd1arMsqCaB0v/rKEHO1vcYOuw0jDfhDdxmOeVyFLyD7pf8raGmJwCRTY+NsdOMzktRgVLbcO1tGS4zasU/tH8FSpTegek2uU69osDHfzPAw+3D0EegvN+gfYSF3b3xq9XtCBgiXHLPDDReb55acQ3ZIZAdOb0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843504; c=relaxed/simple;
	bh=E68T2ZkjnQfOB2TtPtritiOjh/qgxTXRIYSNsvI6CzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUKo/RFq71IDZMf7/eafhWplNq4eO2EAaf+tzH0y0QIkloQDx32nFsoLwgkaVmqKE08DEUNQtNXrfmNDUCojJuAJo1I8j9+RAi73ocef0GQnyYTpIjdGHERiHnDW8gyAKKEQROICJha69Vnk5y7zseNRca6DiRNlHzJL16pDHZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZf5k1X9; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-63d8788b18dso1440532d50.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761843502; x=1762448302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E68T2ZkjnQfOB2TtPtritiOjh/qgxTXRIYSNsvI6CzQ=;
        b=KZf5k1X9bxs1cxIK23l+w9I/oMmpg0XjlJPmml2dLDopGrLZWiUSajApfBzYUDLq+o
         X7dGwaf1kKx+3g45IIlwl4OGqtlwWrT1X6BNWbjiAN6WzO/IKdDcIG5eCtB2kb5Q6CfT
         8i/S+dZFFOUOUdiK2nnpKhlfdPFOr86FmjPYct5VYt8dqRbJcbFhj6sAz0oVMMhJu3ya
         NeLfqkL5T3v3Rity4jEnonwBOYOUkIuEGm8DWmZnU/qOdb6m3hZQJ/m+PSFpl+KAnoaZ
         KA4GAz4vNNfJoYEnW7MaVqekwh4gVVKI6mbx3D9HEW2oTcNwJEVaSdeQ/dNAxGN23p6R
         ON2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761843502; x=1762448302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E68T2ZkjnQfOB2TtPtritiOjh/qgxTXRIYSNsvI6CzQ=;
        b=EFdddCtMsNOqsSDf3wCx9WtzS7/SoVzET10l7HaLdP9gyYQ/hk5LyfEwMiZTlldZEm
         mcM3KK0pLJWEuwoXCpOYA0oD9CCdpg2YlAYMHrIoZBNw0ol6zktvpqeZZSBxIu9csAhA
         WHg3Olvk2gfscwHRzV5Vitg0F0vRBj7aCmYOlI/ulWEdBmgC2L+8XfkcqcgFBogIXLrW
         amW4Kwh7oNi/6zGha0tXZXjlqMULD4kKLUyFJwchkJbK1sR4idToYltU7e6cezNT+/7e
         0D517T68LfMngc3ouEJwNeMhj7HMXWZZWJvLLxuBiSW0HqpQfTLWYdDhDKgZZhRdbBMJ
         Axuw==
X-Forwarded-Encrypted: i=1; AJvYcCWKjWeL6/diGWHW0Fdxjv9n+jHvD59y0p9C6Wjp0f6BXHQbwva/rt4w+jiIV1YS30sLRmRXLp2BXm5NZCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YynzmtLfEYuQQcH/IzGK0yMfrtYdrG2zYCwCoJzFwX1DWGtlC8q
	PceKJZvXLvvLfv1Zb4a9eTUovODjK5ci9a4jISdE+mTZ4B5bremcaKg4J4QcD9rkKyZ346poNQI
	q7ikbU4H3t4wWowfaRdQ15elVt/m7b8Q=
X-Gm-Gg: ASbGncujv/xz48izGb6wJgAtYWjL+ebLC1YpshfhEdGUpk+QgvPV4FZCABciZ6irRn8
	vMMXwsH6wlX0dzVxVNcWh/mziC+WoZlAgswmLDEGbC4Ohukcmx0/QHs2SELdNDw5mZQNT0OG0Ua
	yxMslPnXF5vWjiR741m94Y97K3z17iaGg5upnugRM+wB/zj2DC5nZIxONxNz1W7825AXfJ3Bzvn
	AI6L/F7JWhSrtSV1EPCLc0UqJ22w7NIGSCe0vYdOCpngjWAqVXid9ZqfAH6TIPJ090JneMxP80l
	+8tjxiUokSgaJjeGTGjX96SdVaOhXYyL5bIe7ymmWcIuh5EiHW0JLShwhMmzLQrZfhZravHzRIm
	88pE9Phbu5gHJZ9zN9UJbJXB8TECh61sx
X-Google-Smtp-Source: AGHT+IHbrUeLeobaoyLbyIRyrMhLM50yjN3yU4t5GGhWsxndX/hdKmL0CE7lmxbO/igBCODfibDQ9Objs317x1v+yjg=
X-Received: by 2002:a53:d70b:0:b0:63e:22b1:21a5 with SMTP id
 956f58d0204a3-63f92261520mr114604d50.17.1761843502030; Thu, 30 Oct 2025
 09:58:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
 <efd2690f-35ba-4104-ac88-4e068984d19f@kernel.org> <CABPXPSKzOhGicdPLoMFy8xvd0Xx5_D2P2pduteY3QhDRV4d2Ow@mail.gmail.com>
In-Reply-To: <CABPXPSKzOhGicdPLoMFy8xvd0Xx5_D2P2pduteY3QhDRV4d2Ow@mail.gmail.com>
From: Ajith Anandhan <ajithanandhan0406@gmail.com>
Date: Thu, 30 Oct 2025 22:28:10 +0530
X-Gm-Features: AWmQ_bkxeHE-cf9YU0GEMawPIITvstN85hgTqjgnSUTHDIlKXFHjvkCTrqkY-sI
Message-ID: <CABPXPSLKa9SasCpunrTSuoYaPcvPGTCZX+FPs9uq19m8a2XNRg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] iio: adc: Add support for TI ADS1120 ADC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Thank you for the feedback! I=E2=80=99ll resend this as a regular PATCH ser=
ies
shortly. I appreciate you taking the time to review.

Best regards,
Ajith

On Thu, Oct 30, 2025 at 10:19=E2=80=AFPM Ajith Anandhan
<ajithanandhan0406@gmail.com> wrote:
>
> Thank you for the feedback! I=E2=80=99ll resend this as regular PATCH ser=
ies shortly. I appreciate you taking the time to review.
>
> Best regards,
> Ajith
>
> On Thu, Oct 30, 2025 at 10:10=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel=
.org> wrote:
>>
>> On 30/10/2025 17:34, Ajith Anandhan wrote:
>> > This RFC patch series adds support for the Texas Instruments ADS1120,
>> > a precision 16-bit delta-sigma ADC with SPI interface.
>> >
>> > The driver provides:
>> > - 4 single-ended voltage input channels
>> > - Programmable gain amplifier (1 to 128)
>> > - Configurable data rates (20 to 1000 SPS)
>> > - Single-shot conversion mode
>> >
>> > I'm looking for feedback on:
>> > 1. The implementation approach for single-shot conversions
>> > 2. Any other suggestions for improvement
>>
>>
>> No need to call your patches RFC then. It only stops from merging and
>> some people will not review the code (RFC means not ready for inclusion)=
.
>>
>> Best regards,
>> Krzysztof

