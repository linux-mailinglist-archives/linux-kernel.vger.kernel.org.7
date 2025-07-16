Return-Path: <linux-kernel+bounces-733692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C48D3B077E3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89AD5584201
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5917D23CF12;
	Wed, 16 Jul 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C0weJCt3"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598661C5D44
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675715; cv=none; b=HwF2mQUEuZfX/9Sfbq0BaSUIOpKQyNCLhJiMOYgzumDTp3cmq6FPFNWww/Xxrj7zNR77OBksQTIppTmS4kKFckLBsEK12mgdLeYVWmKiPd9ZJmd3QnRjKHTkUEqhdqxAJH/tLJwRojcUus2dSP95xRzDNN8nOMt2WDkDWgsMKOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675715; c=relaxed/simple;
	bh=b5WU0cXHr7v+e7BT5Ibw9679ejdgncNvKBhfc/UOLmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fc7i4tGIgWHGxzFCv3oCPTm1+woZFZF8Qm4Nxc+M+KZmXtD+Al7xRBlI1Melhugv/9Ah+qqAPviaMJdeGFV237/yF7HEvkn8R9/CckfkfPqeC8V6aGj61lGpRS/gaBvAUbiBqo7L3/uVGMwEeWHk8SFUmstTwJ0bJH7ckyWNn7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C0weJCt3; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso7157221b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752675708; x=1753280508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRgANhiZNBnDfTk3Cs6H1fGZwr7ZYCqusPX7KWdZOuI=;
        b=C0weJCt38dB9cVd2YJeazsDLnFdjy5rfq45drAFRjOg3MuccYU9xxtnFmLjTSLKXKD
         NpO6ifW5adadc1cZOFNZQmCj0doY3XO+UBQe59vgfiQEmEQOHNjdvrTBNrZpXJgz1quq
         VaQxMAy/pAfochemRJZbFgBfov5OHJJ+wmjCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752675708; x=1753280508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRgANhiZNBnDfTk3Cs6H1fGZwr7ZYCqusPX7KWdZOuI=;
        b=nCtge1e0Zd9Dx02SvqUuvcc2ALjnXs0OZfHew3Wc8yqHRB0BsukOyXSyb3wx5F86wF
         IR5gqUPtonXOTQfCzjKqEbh/mIWBT7LC3TDvw6IfKZD40sxJlpGYIJUm3CZUYqjHKj6B
         DfY2bWUuc0YfMp6nsee5mjuUQHXcXDZGVGHDZzcUQi5UYSqutWEHv2vhpIlH6bOksWor
         DkQPHy9jFdeXR2cD+cobLP3I/jj3CUAZQpmfCSD71GEwDIQA2R68jaLSlBytaDH/Z7bx
         daelNTjmLamBCRXa4w4Mbxn2CGUSftEtk2r21eV5kWq6vFeptmaEUOtStPTZ3f92F7NI
         64Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUWPiNTO0ZnEx/I6BF9L/lXVWYXmZiF+pgfi0JEozBzxSFsjrZeo8KgQZpIzf2X5m883aRnRvxqhBGhc1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ZQztiQT46cdGmqYqbFSnxSGIfUQdrkr7ANb+AyL4zPrMrHHV
	Ma/OZBOO/LbxUNTLWYp/WSj5gb/gB1MC0kiIcW4Zs1mAkjvfi5R3pdA1eFtqVjnFRud66lF5cnX
	HIkM=
X-Gm-Gg: ASbGncu4/qN6TwjRrIFjpl9TTq0btGnamik38vXuVkVHtGPBxmTu9EcRWiLswjozZpB
	eA7cuhlHy+GoHhX70etb2XH6UrBhfu7sFvbZ3PQeXsegZCtj5TkKwbsujhft+Tcix1l+BOBvHT9
	+KxN3fCd8GUOlXqokK/gNxIXnB8RZUH8G+w0Mjr0HmWobBKAZ0Zfjh7g7VSnpC6Hol+5gAkZwDK
	rm26Uom7gryqzSzW2hKcRR60rt/+LA6idAQclQA5Ue7yzQ0AnGgvCH4/iPL4qh1iOdaoh8+8r9E
	YBwm0oxgfMRL+hAHrm1AZ1m236OJ6veo/hIgrKTnBaSYkQbgod3O7KmkG1AvYZYZu+8NrFdzmQT
	dDV5ACET7KZ4Qx7RwV2gQmfC+OaRVvugEXrdkMHgEZzKVOKvGhH1RAPgYeqh7nbrYUBSaA+iz
X-Google-Smtp-Source: AGHT+IHOYHV7J11fBtQRy7cm8Ph9ZiqyxxCpsP1csdoyG0Bp4VjLTmf7fcG2D1QleYPJIn4KbRy78g==
X-Received: by 2002:a05:6a00:460e:b0:748:de24:1ade with SMTP id d2e1a72fcca58-75722d62d06mr3920731b3a.7.1752675708492;
        Wed, 16 Jul 2025 07:21:48 -0700 (PDT)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com. [209.85.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1af40sm14301674b3a.72.2025.07.16.07.21.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:21:46 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-313154270bbso6231004a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:21:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWADnKyoHf03bmCuQOj/o+ylpt/qNN8AuQ7yUxqewBwrpF8aHe8l2G0SnDtMUUNMB0A7AKxy/qkluu4HpI=@vger.kernel.org
X-Received: by 2002:a17:90a:d2c8:b0:312:1c83:58f7 with SMTP id
 98e67ed59e1d1-31c9f2e1b97mr3914439a91.0.1752675705212; Wed, 16 Jul 2025
 07:21:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716-topic-goodnight_cheza-v2-0-6fa8d3261813@oss.qualcomm.com>
 <20250716-topic-goodnight_cheza-v2-1-6fa8d3261813@oss.qualcomm.com>
In-Reply-To: <20250716-topic-goodnight_cheza-v2-1-6fa8d3261813@oss.qualcomm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 16 Jul 2025 07:21:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wn4C-cs1y3obzxdtdYcSM44m=AJVnb+Pn3kaaos2ng5Q@mail.gmail.com>
X-Gm-Features: Ac12FXw3qS1FXk204atE8vfiTTzOmf0rWggWMgrUTIEYVKUJNOkL9pqvkeQi0pU
Message-ID: <CAD=FV=Wn4C-cs1y3obzxdtdYcSM44m=AJVnb+Pn3kaaos2ng5Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: Remove sdm845-cheza boards
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robin.clark@oss.qualcomm.com>, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 16, 2025 at 3:16=E2=80=AFAM 'Konrad Dybcio' via
cros-qcom-dts-watchers <cros-qcom-dts-watchers@chromium.org> wrote:
>
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Cheza was a prototype board, used mainly by the ChromeOS folks, whose
> former efforts on making linux-arm-msm better we greatly appreciate.
>
> There are close to zero known-working devices at this point in time
> (see the link below) and it was never productized.
>
> Remove it to ease maintenance burden.
>
> Link: https://lore.kernel.org/linux-arm-msm/5567e441-055d-443a-b117-ec16b=
53dc059@oss.qualcomm.com/
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile            |    3 -
>  arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dts |  238 -----
>  arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dts |  238 -----
>  arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dts |  174 ----
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi   | 1330 --------------------=
------
>  5 files changed, 1983 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

