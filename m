Return-Path: <linux-kernel+bounces-733693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C617B077E4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2684582837
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41BF23CF12;
	Wed, 16 Jul 2025 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EjFS1Hxk"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3605194A60
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675733; cv=none; b=uajNhkTtu+aTkvBmGZiyHidd06VK/KJiDBuMoDNx08IVtoBbdC2uGbyHnKJyREyIsiPf2OwVVhWz+5aSbEySrcwkvAQWSvbrkjvb/ZQ9T+HYgn0JRjbqLr8/skomZPNGloUqT02F2z4AhKAlawgyEYAIbPtDonP+ppPinBd6W40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675733; c=relaxed/simple;
	bh=qaZ1U+EgInwMaLZWb6rGxEaSX9h3KvSTvEqAi3ZlncE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqEWpM/grF8y/ndsqlsOzW36ozeua5MW2r+tFU8e5m+gASSKBJrnq63zHIrkISVzSC6L5UNSBLzAKxALF7nymbS/5gIyuZutWXFwRGGVh7h3QV+iUhlX6oOB3zHaje5UB+oJpaZ1/QaDFG53zisoCoaGDUS+6rdJufRiEtzD9QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EjFS1Hxk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23aeac7d77aso52206555ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752675727; x=1753280527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mz5RRhyfwITv33oCf/7iVVV0cKwknfvfP+MVHktAv/o=;
        b=EjFS1HxkuR+R9DTScwWh4w06Svq1s0TePyk2wgm/UYwhXqFX3Hd4RqXJv0ekcjuSgn
         J8UyjgOnK6grlUsgVL82pdaw03UToayOFG3Qix/R7GAQEzJ1/tZbcMsbvJbNTt+/ayW6
         SwTRVWYKLt7AYI+gKyq6e0E+uFHqPSiBW8WuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752675727; x=1753280527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mz5RRhyfwITv33oCf/7iVVV0cKwknfvfP+MVHktAv/o=;
        b=XBY2mo1x+e+K2MNyH1xuysO5ydhfHTeW0f3YqQHh/r04nc07N9LswjmIXDmCDXA5Ay
         j25y1Hho1CKSdcXlENxymOWy/Y1SAAayJU1QV07eN8D7Zsdvk5Qj5OahoE7TlH3lLVCi
         fEmWzi4ljxQdXsiRitliM6T5pOnRwOk+M170e80edfM7I/v4PNiLWyn+EyyC5Kqmuvtr
         V9TQsjN0Gq2+s/2stjOj6mVQGDUPj3eKcwBhyf131wUR81h5kxyNvrz835kZXOYv/TGE
         IfSZoZrwwxghM77AlmKv98VL/KH4iiv3HbSt49y8fmnsvwbaZBo1KURnIYll13tNiQRi
         UpKw==
X-Forwarded-Encrypted: i=1; AJvYcCUjlEK9hzBaqcaK3rTsnoT2aGdeKgjmTuS5Vyp+Fo6PBGVHjoiEEyaD8tfzBGYtUUWrmaAIQuVc695FddY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy3Sig0KzM41BhU3Vx1pfSx9aDdE+7mq/u5rcMWwxMlyLL9bwN
	n1wWdXPn5UvgtGmwaajRs8b+fvjSjHvEI0WCXZKHSS6P1riluAxHu0JzWfMNqjMePND4TXtgx2H
	6s2U=
X-Gm-Gg: ASbGncs+k3hNzgLK3xSWYEvfCW3ZAhP03hZZ5qj9HIWwlGe8sYnen6mE3PFMGhtTIYK
	egDrIGDOhWvjFA0Jbw4z/RyscEW+TPvGe1weW94DlkvdZ5wwDQeG9OMKkqDLE0CLPm5n/h13JcG
	tP6yBNbRZKLPyxOPkhS+KCbbwSDGcsCDDwzdL6XO3nlPvw7HVETRNu+U4PkOVkr26c2Tup0GKpk
	l/vndbxif7gdZp5d5bZqULX/1hnyCL/HzRED1sbWri7ZasWA2U/HR0Str9IL9+Wl4tIpi8Jt59/
	EGILh1I3Avw05a+e6NlK6J5+yjYJzXA1jRiekw5Y2wiQvFng9XioR4x63IW+FDxJrAL90xOPUgU
	plGG+ZbgSm7h3I3UmEDtA8ROwjdmH+BKXBBYCnNTYc9cqM06n4mApmFhEzZ/Jrg6eIQ==
X-Google-Smtp-Source: AGHT+IEY8mObL9JSfFfryc9RsG6sWolIJZ3wz4yPHXZok5AO9Uh/tdB3Uwirlsp6hGQbMUMdlHmDIQ==
X-Received: by 2002:a17:903:182:b0:237:e696:3d56 with SMTP id d9443c01a7336-23e24fbef08mr47811535ad.32.1752675726925;
        Wed, 16 Jul 2025 07:22:06 -0700 (PDT)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com. [209.85.215.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad2a0sm127100135ad.56.2025.07.16.07.21.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:22:03 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b271f3ae786so5034294a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:21:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3hF4KX45dzFGZBnysHLj0IQdBEvPiaDt5GYX1mtoN0g8CpMpTM+98OHol83xlRTLGxVYxroGEe6TK+b0=@vger.kernel.org
X-Received: by 2002:a17:90b:1646:b0:2fe:85f0:e115 with SMTP id
 98e67ed59e1d1-31c9e77cfe5mr4368025a91.26.1752675712704; Wed, 16 Jul 2025
 07:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716-topic-goodnight_cheza-v2-0-6fa8d3261813@oss.qualcomm.com>
 <20250716-topic-goodnight_cheza-v2-2-6fa8d3261813@oss.qualcomm.com>
In-Reply-To: <20250716-topic-goodnight_cheza-v2-2-6fa8d3261813@oss.qualcomm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 16 Jul 2025 07:21:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wj=J0-3rpjEsdLzgHzY3nXw0CWaCTHfbkNnu5H=VCPgQ@mail.gmail.com>
X-Gm-Features: Ac12FXzTw0wKAIsfrwSNsVdCEfNSNshL9d8ykTsLQev02btB00hc45WqX4Wa3pM
Message-ID: <CAD=FV=Wj=J0-3rpjEsdLzgHzY3nXw0CWaCTHfbkNnu5H=VCPgQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: qcom: Remove sdm845-cheza
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
> Cheza was a prototype board, used mainly by the ChromeOS folks.
>
> Almost no working devices are known to exist, and the small amount of
> remaining ones are not in use anymore.
>
> Remove the compatible strings reserved for it, as, quite frankly, Cheza
> is no more.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 3 ---
>  1 file changed, 3 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

