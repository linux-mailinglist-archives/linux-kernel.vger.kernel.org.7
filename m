Return-Path: <linux-kernel+bounces-733714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A729B07821
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 499937B4E32
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967F621C9E3;
	Wed, 16 Jul 2025 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ebCwYewN"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C44D263F5B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676228; cv=none; b=ThnhUQuA601GiMSU7KDJLwF0qJd9XvD4uRbTKNKI5D+Xs3prlT5TVe31bZyba2y+siszcyoejF+0TwqYvPAhmTFJwDRXm+DdeR/xFj2spxl1dAKyVd0JajisaprTkAtP1IATgZpl61FGbME+IxMwLXduIvPcxZ3qQaJleA36Gyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676228; c=relaxed/simple;
	bh=t9cGAC1V8k6SxfXrsLQjmHsOU+fuaxnp8/UHtdTovTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dq5bxIJ+m47Hk55frmrIqEJMkwbg0MQzdedklyjME3iNYZsTTRv7Z7lk/EKtVT8Xmy3yEHivGbmNrkjmnLiUIoF1IMCkySMbGhEirEZLMwF9uFerzqTSZP0Yq9fCfiCpDsFpM2werqpt5CW9FdVWGiHl7rv1flvBELRW2/eu1Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ebCwYewN; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3de1875bf9dso49766535ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752676225; x=1753281025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptfKV/lWd5XKyT6rmwDogz+72ly7gZepKQSMRpdWixE=;
        b=ebCwYewN0cfWHCIDiEvhvvlg5ltdgS38KR8XtT9Gltc1VUjhZFIY+oENrbBtRB7LW6
         /sYlQ/XyRW3yn+FvAf0gGZOaoZ9fOtlBsZNlVDXS+qcl3E60BUMuREvkDd3qXN5lmKV9
         OsTJzYsbthjnTKHJ65eiW388GGAmWfbaOq2F4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676225; x=1753281025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptfKV/lWd5XKyT6rmwDogz+72ly7gZepKQSMRpdWixE=;
        b=pVTXd/yZsZJ8oDVdUaQ0wWrcWurWDkdaC3Z3K5hc/j0s0B/7svY2kuAO0huZTx9KEW
         pcmjH01oNSulNCJb5LkTZDPfxVvM8cpo53vXDI1qnEveOUMf8bq4SSVXoIr/rtFBt8Ji
         nJ1hR4gxWlWm3u/RVRjosQX09wBl8xYFUtEOWkCREyYL6E10a5w/lgrseUulneVJDbm9
         gNSHl7+IboYHP9CiHNjRYB28VxA/EXdHM40ahxw6eQMa4flw0GEJ4AOAQbZYInh7fngE
         T8oMAj2zXqiBS6KicSvXtIGX0ZSwoGY8zv81Ay9mlAMFm8mwiGgJkB7TsTbR6sV8qguk
         ho7g==
X-Forwarded-Encrypted: i=1; AJvYcCURTTJuwXkvS5XohYdD9Um18AiPalxdkq0vvkP76AN4q0tNQ4tOYQSCsNRiR3jf57DamrefcPfYDfCjFGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdplASKPbpcarIQ9mraK2TxczKs5esWya+pbQr6amGNDyxFG8H
	g+m+je04xUATQ5mjawM8CTSkZF1XAmZJX7UcQKDE9MF1/SZ7Di48frNhm/ophrUvK3BYjkgmut7
	vEWQ=
X-Gm-Gg: ASbGnct0RNQigqHIznWpxyBAR+f2tf8Xjb8yeQAkc5niycrAxBf6rclgqaE5Dk7D3Uv
	Gm/5+S77MWoVKL0bfXJnYzBaiBV5Fb39NLynpaaIc63hXirtavC4zBGSZkm4eLKgyl/xeglpKGd
	+7wXQW+mFP6fs6grXLJ6gks3PydPWSrVGLS7kAQcu1p9xCvtJLE2jIKBcdbye8k75Q0Biybykj7
	7xfJSGo0zOBQSb0xVyhzSatKJweWvYVmwSuO9LzybQUk48gbtH5Zl3DWfg84yPMfy7N5W18wtJ2
	ugCGjGyUOdvYParRdlpK9r81Xv57kZZZQGgXElskX8fjSDhS4oRvdttyx3PFIt0QFCKAIsCzHPQ
	Hz75+wepcUsnZXHzfJsfSG3jfQ+Regr0mRctrylkl4TkOi8mDHXnyKRPu7HkowA==
X-Google-Smtp-Source: AGHT+IEgUzNVrwsGgWdWdW/ibWycalRcRadT6OIciw7HvJuu0B3JrERlOfRo55MjbRvcCARda6+MnA==
X-Received: by 2002:a05:6e02:2303:b0:3dc:7660:9ed9 with SMTP id e9e14a558f8ab-3e282c41658mr28334765ab.0.1752676223818;
        Wed, 16 Jul 2025 07:30:23 -0700 (PDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com. [209.85.166.41])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-505569cc6a9sm2969431173.94.2025.07.16.07.30.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:30:21 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-87640a9e237so521991539f.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:30:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXtP9RPJrLcFspI/WM35gxwDoGfzwsPs5cSry9yzdZi0CxowSB8PyTt2ceY3qLp66fXhbo/ul9ZdDMvx70=@vger.kernel.org
X-Received: by 2002:a17:90b:3c4b:b0:311:fde5:c4be with SMTP id
 98e67ed59e1d1-31c9f45c8e9mr3962513a91.35.1752675732176; Wed, 16 Jul 2025
 07:22:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716-topic-goodnight_cheza-v2-0-6fa8d3261813@oss.qualcomm.com>
 <20250716-topic-goodnight_cheza-v2-4-6fa8d3261813@oss.qualcomm.com>
In-Reply-To: <20250716-topic-goodnight_cheza-v2-4-6fa8d3261813@oss.qualcomm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 16 Jul 2025 07:22:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VnE0kUk58GxmfwwZ7eP-9xe1Hqv8n9y2tHkiMK3nwFGQ@mail.gmail.com>
X-Gm-Features: Ac12FXz8ywMx4qZ-nfHra53TjelQ0XaS7lSbI5YSdJlI09vDJzDmVP6OfgYR9ro
Message-ID: <CAD=FV=VnE0kUk58GxmfwwZ7eP-9xe1Hqv8n9y2tHkiMK3nwFGQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] MAINTAINERS: Remove sdm845-cheza device trees
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
> Cheza was a prototype board, used for developing Snapdragon platform
> support on ChromeOS.
>
> Since almost none are left in existence, and none are left in use, the
> device trees for that family of devices are being removed.
>
> Clean up the maintainers entry with it.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

