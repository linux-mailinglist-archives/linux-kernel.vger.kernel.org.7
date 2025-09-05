Return-Path: <linux-kernel+bounces-802875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D4CB457E0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D22E7C7F1D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF5C34F49F;
	Fri,  5 Sep 2025 12:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbBtjJog"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A293A34AAE8;
	Fri,  5 Sep 2025 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757075230; cv=none; b=VEwRGCsjqAKwYKUE29hCTQlAaYavWpvaZwrwHziCVk4Q75JokKn2Hs3d23308pqyCHeNUX17EOWSgrnrYwOuM+CwFcw061P89pEUDDevBHuoi6bh09FEhzZV+u6tyuc3CPydeibKKLO2oj1EFnCCxP74+6kTesCHho5noUr8ttQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757075230; c=relaxed/simple;
	bh=2ClMPDF0HluOKzI+GNmsNWO4LtH4Zjjqg5QR4CqPXIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0KW2EkzUjN3AZhm1SnpFGgiHBv2MtELSdSeDoKMu9ZiCQfQZtUKzgf3tZXivckSBNJEBVuV82jAsbEJQrV9xf2OlwgOCTfKmv2w/UERsj8asmY5BMZYxljCCqpy54KBeLHTw2my3/51kCSv4iFqqW6q1/T1XK6oYC8u7vnVlzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbBtjJog; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-620724883e6so2920294a12.2;
        Fri, 05 Sep 2025 05:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757075227; x=1757680027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ClMPDF0HluOKzI+GNmsNWO4LtH4Zjjqg5QR4CqPXIM=;
        b=QbBtjJogFZsvmBH+gzssaneSguaif3bVV/f7LBkZ+N1WWJeQMBJZT2DbhuMUPxD4gC
         cWLP0L+vTXd3tcHgXPWE7rO7OF3rA+cUL748B7fijudohnJjnFXL0CcwO7u6AVtXWqi4
         SuTCvYsPv8rnHP/hBFvi00s4cL1eYda1v89Gr+Bhw9OkMx0/c80dAJ4SmNuG/iI2Cpwd
         3cWCg7Zsi93v3MCfX5QRdjgmvmd3ZDB9WOv7agBQrL9lCkiJ0oFI2Zyo6OxApXJVU8B+
         g+jbqZ8n1pQSrwzzKEK8+W4jS6kRbRbCLrEJrb6Tgp8p4Y8V7LHC42l72Ld1uZnUGlCk
         5bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757075227; x=1757680027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ClMPDF0HluOKzI+GNmsNWO4LtH4Zjjqg5QR4CqPXIM=;
        b=ilR2dKldQgM0eMYZGbvm2/SR0PuJWG4wgi4miGG0y9/1Xjnwl54Ra3jlzJCCpo7h12
         k/s87i4sPwucNw96k0dt1fvfw1zpBmvnqV/4qlwsAYTSMO5uHpryZjB149beojgYpuFr
         UriepixthhU6RF9DWn4nH5GLSO9gwandFcOqyVqkDdmWV+ASUOWMb8rDjioAgiSL0+z3
         i0r7mI1pWp1VkpEJ/WfIkIRgsObxc+haLsFyV4sqyfbz2+7pNtPgAFFwm3HsOJ081IZp
         cXwJ2XePUWsK07/W7oOe9p9dkEvTJG7koBdaskLLbj8OYLeGB6q2gzF7qU6GzHmlUGpo
         e4zw==
X-Forwarded-Encrypted: i=1; AJvYcCU/A9T7sNaY467yJ4VO+H5ogq6+0cV874GuHZONDy02Dth40BF30doBMyz1JkSUdMxua5z2KU8iQfeM@vger.kernel.org, AJvYcCU0lAh2jX4HG4IOeRQCgaKvMnQVAbsL+rbMs9X4dWqFB5G626F4HZZ1vOSFlI+UVWYrk622xzh/PQOcvz4h@vger.kernel.org, AJvYcCVaAXxOZYbH/gF1AA2YWV1PEvGdJyqxjaAMHfVwWHFO8vtP0qLNdDaj5XsDYjsR1mRlichvcmDedmwA@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8GNS3Tr22ZYtmQPEOimM/IQ7zWbXhEsEGNsxOItMdIK1wrDcd
	qI5VfFgAGX39uk9y3llLMxwCH9wYGftxXP0v3XBbSyMHL5jov8L240Uq6jISRv5rHRl5u+I5ogK
	mL6pnsB/AXMJz2/Y2ftyOiTGNOBcnhM9BQ9Y6hPYuFcRE
X-Gm-Gg: ASbGncvKFZKLpNvcDzoo2QJ9hjGulhebPC2so+vcxvNfOcw3Uz7iiSNxZOuK36U+f/u
	pUNXxcUp25bo9ITAAQQa3qKyIWmO07OxBOspyPqeKuB7vHD/uxhdtHpS5xDirUmA/3Th9cC+PmM
	qtc5Pkx50t6WJUQFmNJ7tOk0QgAVtEKGCcgw3GI/j0EvDfjF6yEFrtEgLbm/x0kFUlQ61mNX5oi
	HSvPYTQAQepLckdDQ==
X-Google-Smtp-Source: AGHT+IEVNnP/U7LUIDN6Mt8LbSIFuDZj1YfEJa6iYw06p0ZNddA0TQZZkmZqSMAeaPrBEuNv6h+hGZaxwhQit2BdnWI=
X-Received: by 2002:a05:6402:27cf:b0:621:b7ba:ef76 with SMTP id
 4fb4d7f45d1cf-621b7baf1e6mr1486424a12.35.1757075226560; Fri, 05 Sep 2025
 05:27:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905025632.222422-1-cn.liweihao@gmail.com>
 <20250905025632.222422-4-cn.liweihao@gmail.com> <2267196.NgBsaNRSFp@diego>
In-Reply-To: <2267196.NgBsaNRSFp@diego>
From: =?UTF-8?B?5p2O57u06LGq?= <cn.liweihao@gmail.com>
Date: Fri, 5 Sep 2025 20:26:54 +0800
X-Gm-Features: Ac12FXwgzlnAMSQyI-WpHzpeUd7ApymhPLAVoBjM7YjSfL1afRnvVV71jtX5KA8
Message-ID: <CAPEOAkS4gPiXddXi2=RqY7oJW60ewwA54=OX_Ljf1zpAgUf+_Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: clock: rk3368: Add SCLK_MIPIDSI_24M
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: robh@kernel.org, hjc@rock-chips.com, andy.yan@rock-chips.com, 
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Heiko St=C3=BCbner <heiko@sntech.de> =E4=BA=8E2025=E5=B9=B49=E6=9C=885=E6=
=97=A5=E5=91=A8=E4=BA=94 13:53=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> Am Freitag, 5. September 2025, 04:56:27 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb WeiHao Li:
> > Add a clock id for mipi dsi reference clock, mipi dsi node used it.
> >
> > Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
>
> another process-related comment :-) .
>
> (1) You already got in v1 the
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
>
> So when sending a v2, please include such received tags
> (if there are no major changes to the relevant code)
>
> This prevents people from reviewing things needlessly multiple times.
> So patch 3 would look something like:
>
> ------------
> Add a clock id for mipi dsi reference clock, mipi dsi node used it.
>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
> ------------
>
> (2) As can be seen in
> https://lore.kernel.org/linux-rockchip/175690195013.3771488.4358707862248=
73257.b4-ty@sntech.de/
>
> I already applied the two clock patches, so in newer versions don't
> send them anymore.

Got it and thanks for your patient explain.

Yours,
Weihao

