Return-Path: <linux-kernel+bounces-847545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A06BCB268
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64BCE1892C92
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 22:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903AB286D7D;
	Thu,  9 Oct 2025 22:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H7istZyj"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E9320296C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 22:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760050548; cv=none; b=nsEDdQufyTcRvD8Iu2+mS2QmOhXEpKtfeE8BmxFFTLjjQeRzghjx4OuANXQJz/iXWxi6mIVoy0bPRQG/Jb6kqmhx3D5fMjNYkEiWHdb7dq3yoeQT/klk+T09wK2yzQNGYfbCEfWTAq9rGPFfAM5+EnCWD/D7K+UHSb2kqAcwdsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760050548; c=relaxed/simple;
	bh=L/uOVVJxa0Vjg6Rg2XdGp0L24W+XSU7os1JdPoYNL4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sb+lTNaQQ+uvzTUyQRSQOdGSsZXAEUaTdep3n2xLf87ZPHx4HsdhezK4TgjiC1KWdsOcS39lW3kN/BsKJhK4TJg7t0oXU0u4hEkIqqlrxnrrkn0WrYP7HtkxBq6gPRNvpLFkyK2X85xjr3E3zs7UI3l7TAdoQnhdqwwLawXfPiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H7istZyj; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62fa84c6916so5558a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 15:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760050544; x=1760655344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/uOVVJxa0Vjg6Rg2XdGp0L24W+XSU7os1JdPoYNL4g=;
        b=H7istZyjCwC4HX/3Hb5ocNSI7PYwVdrXv6xAeOLkMTiy0TKKnoazdqbwXK+TwCEtdj
         w55fmlu1j+lElm4orYUiHvECXPulmvkYoW25nAJKAdRoRdp2nqxMLyl3cXTZaVFIF/NN
         9oWKchkSrea87fwv6JAOGT90/0fzmIrld0aIOt54TYo2HimvSqN/kkfxQvExqicsbdbt
         9t+1PSOCjqtIp8UU7m1HWt3V0hkEx4gyR+CY11Z6tnnCPI/RfpnYhaeXyCeLia2fDNR2
         s1GpLYvFFSkRV4PR+EFPpv0hmsFUCUuRHggVcEXTACgL6anSoceS5QjUDE9opwsCckYZ
         MXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760050544; x=1760655344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/uOVVJxa0Vjg6Rg2XdGp0L24W+XSU7os1JdPoYNL4g=;
        b=eUS9qN28og1uYqAtsrQyr26pe7LhFkX1fDE07jZAKm6KowpW9W7fWhBcPXP7KJkmNz
         UkFdD5lJYfpjD5vgEspXIAEXoC+iMsDAIz2v8J3znUHaUHhT5JbzaNEQkk7huOtiLFFn
         lS3g5I3iJBhTuLObKL7NkuAnTj4zaGp/ZHPnegzBQMCcdmDvgsv5O4crbhdcx+9cLdqH
         wGQbJuIfeFiI9HV5qPfiUkpm1RRRSMsyszFkqwC0nZCB1Nwel7HRdDB6dGaY3nvD8ocT
         DPpA1OGP5UMnlBKCCU+0Umfzw2Wlh5Q47zlTAgfpWTcWiACYBr3ZP4jpncBhTzrMy7MX
         xk0g==
X-Forwarded-Encrypted: i=1; AJvYcCV0Ut33X+Sx/ozwkQTAgfJVJxbXfc2Wk1D8D/8OK/ceZ1gdWMrFS1s3ZNrmP4O+TPFloSBV2f+L8fBgn2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSfSkwlOuO1Iz+bux2HZ4EASvFvgxEvlig/UDIbSZoDXVg0lSL
	3YsyaYIwQ7odgu2jpca1gPrPwDf3ULS0l/sNAhSQF+2PEW0EpKyc8SQrghhd6sABaMOaaovCRdS
	qBPlkgUVxrsFEh6lRqKa2+NNt6GRItU6HdS8sg+8W
X-Gm-Gg: ASbGncumavvIzlOQJ0d/qmWsoAgke2uIl9IJVlYKsXJ5YJjohTaZZFCmt6iJo4O7x/0
	XRwU2d3toOEqqDaxBCW3/76YO1zv2EPpp4m/TFe07cAxZxBuNErHV9y//EeUfemmBLzDyHUz9UR
	EWHimyEx2PbD5CPrjUP6NTi8I8m6j+GFJTEbr5rG0RBZR/Bi2XXSBzHBjR4fcO55CFnNRSm1d8j
	ghRhKKif1Sq35AzZHo6gT9B7+KIW6ctsnwQho05CbzDouz7
X-Google-Smtp-Source: AGHT+IFtEIp1lPIe1h+vRaxhMKax87qlktoQDl5DPpMmr89GoDxH8/qbNe1TY3lmDd/nEtpZKLV/ufs5dB6mUjMCM60=
X-Received: by 2002:a05:6402:70d:b0:62f:c78f:d0d4 with SMTP id
 4fb4d7f45d1cf-639d52ea25amr280278a12.6.1760050544364; Thu, 09 Oct 2025
 15:55:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001145816.1414855-1-yosry.ahmed@linux.dev> <20251001145816.1414855-6-yosry.ahmed@linux.dev>
In-Reply-To: <20251001145816.1414855-6-yosry.ahmed@linux.dev>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 9 Oct 2025 15:55:32 -0700
X-Gm-Features: AS18NWATDdsUyWZvLc2joY1-sJnSzc9Iy__XCFHTGQXE8gB6pObIfutGF2HxCok
Message-ID: <CALMp9eT5DjpTy_UcU_99uHjSWymk09riWePTCzZG7RyHb5KFUw@mail.gmail.com>
Subject: Re: [PATCH 05/12] KVM: selftests: Remove invalid CR3 test from vmx_tsc_adjust_test
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 8:02=E2=80=AFAM Yosry Ahmed <yosry.ahmed@linux.dev> =
wrote:
>
> From: Yosry Ahmed <yosryahmed@google.com>
>
> Checking that VMLAUNCH fails with an invalid CR3 is irrelevant to this
> test. Remove it to simplify the test a little bit before generalizing it
> to cover SVM.
>
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>

Is there value in moving the invalid CR3 test elsewhere, rather than
just eliminating it?

