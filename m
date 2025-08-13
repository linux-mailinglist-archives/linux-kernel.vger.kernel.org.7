Return-Path: <linux-kernel+bounces-766879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E111BB24C42
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6CC5A567A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2217C1B87E8;
	Wed, 13 Aug 2025 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SZRD3KoK"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021B02F0680
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096004; cv=none; b=B+E1RyE9nrxlSqTb6vMg7u09tnUkf0H3Am9/6f0dzToXbbpFX90B65nRHd4lVzNmBY8Pd+CTO5NfP/sc/SBFfLXI1LaqUB5SdOhYTa8uwLqoar27wbOf4eHJupNacs0A+kbzk/u7mZo3J62Lk/FHo5XI8kTtJodWqtErKId87ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096004; c=relaxed/simple;
	bh=jI0WPuGn6MX1RV97Brgv/DvEN9Nzfxb26uc678IZcpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/bOE4Dnb6NxqqhCn9TjGBdnCeCYfcIBma5VjvA9CU8T0f7IQD12L4Hu9FyMEXJDW7zP2iMaN4PbaIXKsu4J7zkEIA16XAYaxyyCw44UCZ1TSdnxR/89RIddMOWTvmuU4tEKe3a6KweEDXuM5MYVWV8FYmElWrwxdU+RfLpJyyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SZRD3KoK; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6198ece73e0so4269399eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755096002; x=1755700802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sV7ug8iAUZr45ytqyo04qfrP0xb0ZjQy7wbsd8qq0sA=;
        b=SZRD3KoKlhGygCWeTiAguSXNx9b8dZs6YXVV2ZNL9pyBUshyErJWAq5cqRNZYp3BCO
         5hdoCW6hQrnFDXPsBoAoeqKcCOi7yRMiBZvTSnEaoRBGv7d/KGwpNuDGM1QowD0op1Rj
         VqyfMlCMNRCATIaMJ/nVUlD/zVzF6l8sBDtBBUiQAsH1J6BYFqwqRdrwKkLSFe7uOUSt
         /k2yL/bBPT/Ca4Ao6cVc2+ePg8N5P5jYadASp0NtJ9GmiiLGUO1ogiYgGen0kro3M96f
         ekhR93wtbO6TyCcn9mA6n3K/O+4FoZx8/u9zFBgtMDEn5QpdosfhGpTpwYfTkx36+T1X
         bxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755096002; x=1755700802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sV7ug8iAUZr45ytqyo04qfrP0xb0ZjQy7wbsd8qq0sA=;
        b=ONuE+98zJPC4NrKOGK3sjHQF2cvv4Rxx8uEWiK/g7WIQMBOZjNS9A12tmfji6PsBsz
         g5X3Gdg34wMOzwpgBb0qh+2Hc26bmOnLuyc874DypE2mDbSqjjLo2Xqic3/QGErh5omd
         IvTGo/iAtiyunFURVRFqHKWo7GT0lVy2EUHOCih0NgYYLZuFQHES3iSrve+eYcdlHJzo
         2B80kJKZuIwTCIHRR8elzkc9D/1/dw7aPkwV+Gol9cWLeWqLiSK3n2AIABSgpWvqbwUP
         si7RwZAk+B6zya5EqgHlS+VUDpIpDJrLiQaOb0O+t9e6Zy5xl8RjhDjHokUquYpVadn6
         tcHA==
X-Forwarded-Encrypted: i=1; AJvYcCWIY7DUy5xdruoDteZvZs1/NfXLiSgmCyYK4W8noj08or8mIy4u+x8BYe+2O4EiH2LtCCTZGcgjAE2R5lU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx27q/+D+uLZ6a8rhVTUV0TdoozdbUQe7kflCz7HX8cUiLt8/Kt
	BDTa2dc/c6FaTF5ZtatoWmsjBaPIjBDlDGUi65EwVXu8gEcTtbjervLpxFKelv0A/QHLC36Yc/3
	JardIYXovQVI6pRoNChm87hWtOtlO1fJIjLsWChscjhddCg4yJfEmvyY=
X-Gm-Gg: ASbGncuxoCOli+SwKbG8iclfg+YLTEcO93FmQ/JniVRwJTr7A2BJ4NNu7Vp4pb/X5r8
	/YY139szuYkiafSYl9DdzUDwCytmhn78/UW/6hWKDQM9ZpId/gB0K+GbsK0bUwWtW2quRF7wzH6
	Ic3X4wxaeJUC6LFPdv9MsWJlJQcwP6POYAQXbyMwaGwuJ3CXUDvXtH5uWaXPf+p5JfAUqEON1QI
	/RDtOf1
X-Google-Smtp-Source: AGHT+IHC7csBnnmVeyozlhE6czCMvb+rLNabVehQ/2DXrtUClUHk7vysXYF5f8+3kJAFnNYGQPwefi4/ihiJTtqrSv0=
X-Received: by 2002:a05:6820:54b:b0:619:844f:2d0e with SMTP id
 006d021491bc7-61bc76a583bmr1459875eaf.8.1755096001906; Wed, 13 Aug 2025
 07:40:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250622082910.13897-1-abhinav.ogl@gmail.com>
In-Reply-To: <20250622082910.13897-1-abhinav.ogl@gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 13 Aug 2025 16:39:50 +0200
X-Gm-Features: Ac12FXyhUeoBN6AsIilsKfGzLH5o-2jBLlxxf0JYZUEHFC0u9_LymyTa00MBA58
Message-ID: <CAHUa44H5OX5CYW5eR2wvtwaywUCNvV0wVtTRsi23YpbSaZofTA@mail.gmail.com>
Subject: Re: [PATCH] treewide: Replace scnprintf with sysfs_emit in
To: Abhinav Ananthu <abhinav.ogl@gmail.com>
Cc: sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Abhinav,

On Sun, Jun 22, 2025 at 10:30=E2=80=AFAM Abhinav Ananthu <abhinav.ogl@gmail=
.com> wrote:
>
> Use sysfs_emit() to format sysfs output instead of scnprintf() as recomme=
nded
> by the kernel documentation.
>
> Signed-off-by: Abhinav Ananthu <abhinav.ogl@gmail.com>
> ---
>  drivers/tee/optee/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Your patch looks good, but I've already accepted another patch for the
same issue.

Thanks,
Jens

