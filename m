Return-Path: <linux-kernel+bounces-847786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E07D4BCBB8D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DC03BC274
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 05:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D782223D7D2;
	Fri, 10 Oct 2025 05:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p2bwy6/W"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835C52367B8
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 05:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760074147; cv=none; b=D78tSJZFXAN0Qy47oA4/W+kJ1kCJrhUAXulLP99cetOEvLs7J+Hu0IaWXG2qHxKvYjE7Z7P3bNRSQV05y5SoGdwn7QmTrqwRkKyH0D7cbeOIMdKPGF48H4UwHcUUxxXvpTymEB8K2Lm478ivAQ7/55Kqx8rRuCKD+G2XpQXnkFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760074147; c=relaxed/simple;
	bh=8aR+InBDnBjn09cnwllCT+9UwMA0LVX9Wn4YRKaxBLY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GX11YLTrc5hTeBH6rqR8sL3lihYRW+MmN6yPJ5oGloWFLBD2vZRnVfD6147r0Ci4AnLfkLiV3+KgUIRAv9Kqz/w9paCgK2KoM+9rzRAncL4D1vF2HtQt3eMap1KB3huf+jteT+xL2eLHM59wWPi7OHtzbYV+MkCjdn7PIpl3QxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p2bwy6/W; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6364eb29e74so3053664a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 22:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760074143; x=1760678943; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8aR+InBDnBjn09cnwllCT+9UwMA0LVX9Wn4YRKaxBLY=;
        b=p2bwy6/WUIHRboQGuzwx3CKzj5GpwrXYeEMxPfjp25vfUnXlElyNPsyvuVjOSuYQQd
         ijT8HZnozmJdj5czSOQKRcL4Oqd8ILE4fZSwwMTYkXiPudrr85EJNXm8dwm31OScRQ/A
         r/9nRC0U1VVwomgPxC3NnHvj1gRqzJ2d7hAC9qtlTPha6IHT1O3Zcp/3jgAWd2ULJK+O
         zOB2h3Q5FW/ERZKgd1k5ok93ziMyMrPgMYsjn+kRko9XUMOZuLXpeUpkqTh9qdvV6eFw
         emv50INM8hLOjWcHTpbfr0JBkTu2w5IcKvqehYIRMHdEnZtMm4qHJ11kjOIWwFTa62F+
         /Org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760074143; x=1760678943;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8aR+InBDnBjn09cnwllCT+9UwMA0LVX9Wn4YRKaxBLY=;
        b=qB3DLvFvyqVZg75DYH7J9rwbzaKkJnFw4B/Fn0Y/1j5aXFb+93FAqr50q6nIlHYJSA
         5OkEg1nOi4KdNP35SnJQo585tbhkM8OMzncfgxvJoyTmfiSOj4Sk0FgcbUHJadaZluHi
         f5SvF6Uftzov2b9DvinUzJQRxxdIrsOJ8QPL6naiWmjyuxcANRIvh4x2OWRwucwCgYl5
         qWol2/37QLI+R/bBWb1mNFoJ99tUqfTbx2CkRu3VbpcVkVEwZqj9JvwFhAaSLIje52JD
         oQ48U4PcM48qbWjqvVei/MJKnyHHZzXBCvkZVCiRH/um50+jcZmfknPB6xsx9EhTZiCU
         TkOQ==
X-Forwarded-Encrypted: i=1; AJvYcCULOdLHkSP7ELoBCykHGXB4HRtaozAyGuPIffDRX6fem8kXtGLSI6ZELK4OQsESoY33d7WpYfSiHoaYp8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY8O1aFbLkijPAnhHmQNRj3RfbSmkwSPwnpA7eveLm5eQRvcKZ
	pcLXoaEitC1SjxmSS7COG1S0MqQlz3EclDcw9NIALorf6b7lObsEnBGB0odiw+KON+E=
X-Gm-Gg: ASbGncv/3pZaQGrkEePSUUUhAGc2rQNtWAcJ9suswkKtjvsbHj2nyTz25yvfcW/Ie71
	ah5x6gav2NRz/0kGX1kMAJJCfJQWntzz4BnSroEnwbBYiRVPzOkJzss7aMboG3zB57O/OlETfMB
	WrACw33QD17DD8mBQz6rZgIwC0YzBtbDmiocbfnrekB7R0UwCdjL9y3sPRZe1dclUOgSSX6z1rG
	vwmwY9vdt2xV75s9yF5jX3Fe42nmHXOFNGcZ9WQp0v4EhnGgykbVJyjeSfoQ14D4f+IIb4mmZM/
	oQjMCOOc9/kOsxN51CTOxuC/lcrlV7fT8L7uOrSvT3z/2/yJKuBWuERHrCsDkWIDWnfwNU0oQ/+
	k+qpW6Mmafzi7DH7JGfrN5UP5ynAQDdckDQcSkJXSC3omOuYG
X-Google-Smtp-Source: AGHT+IG0R4w9Z3PlluIRXd9lN4bhh6YAYGuTKxcKQNJqwpna264jwoUI8J+xZkraphoRjdWXanfcWg==
X-Received: by 2002:aa7:c594:0:b0:634:5297:e3b3 with SMTP id 4fb4d7f45d1cf-639d5c79798mr6900276a12.38.1760074142813;
        Thu, 09 Oct 2025 22:29:02 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a461703dbsm1459171a12.0.2025.10.09.22.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 22:29:02 -0700 (PDT)
Message-ID: <a00c61f8c705ace0838ac021489d5300ea95dc21.camel@linaro.org>
Subject: Re: [PATCH 03/10] pmdomain: samsung: use to devm_kstrdup_const() to
 simplify error handling
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>,  Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Ulf
 Hansson <ulf.hansson@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus
	 <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date: Fri, 10 Oct 2025 06:29:01 +0100
In-Reply-To: <ee66dca6-3cd6-41d3-82f9-d2673da00287@kernel.org>
References: <20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org>
	 <20251006-gs101-pd-v1-3-f0cb0c01ea7b@linaro.org>
	 <5df18f42-b567-4d27-9e12-29723af40d6e@kernel.org>
	 <9d4ccadf76ccfff1a8b5f572b8aa190e2dc40c29.camel@linaro.org>
	 <63fb3ccc10267add00b579d4a05497cbeeadc65e.camel@linaro.org>
	 <ee66dca6-3cd6-41d3-82f9-d2673da00287@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-10 at 02:35 +0200, Krzysztof Kozlowski wrote:
> On 09/10/2025 23:00, Andr=C3=A9 Draszik wrote:
> > On Thu, 2025-10-09 at 14:31 +0100, Andr=C3=A9 Draszik wrote:
> > > On Thu, 2025-10-09 at 09:13 +0900, Krzysztof Kozlowski wrote:
> > > > On 07/10/2025 01:43, Andr=C3=A9 Draszik wrote:
> > > > > Convert to using devm_kstrdup_const() so as to simplify cleanup d=
uring
> > > > > error handling.
> > > >=20
> > > >=20
> > > > This is either a fix (then describe the fixed issue and add Fixed t=
ag)
> > > > or you change the logic, not only simplify.
> > > >=20
> > > > Previously on of_genpd_add_provider_simple() the memory was not
> > > > kfree_const. Now it will be.
> > >=20
> > > Indeed it's a fix after all - While the driver doesn't allow unbind,
> >=20
> > Thinking more about it - at this stage, this patch is not a fix. The dr=
iver
> > can not unbind, hence there is no leak to be plugged, hence no fix.
>=20
> It is about error paths. Driver can fail binding.

Thank you Krzysztof for your patience. Yes, I had overlooked that
of_genpd_add_provider_simple() itself can fail. Sorry for
the noise.

Cheers,
Andre'

