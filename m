Return-Path: <linux-kernel+bounces-836673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F02BAA468
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 20:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0281C455A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ADC23026B;
	Mon, 29 Sep 2025 18:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cedQlwuy"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3822F228CB8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759170072; cv=none; b=kAE6EuuSTIS7mk6OtSwA+rHcptkCTG6uOEJ3pgMGh0rCIPtKA6j1qz1Qrxe43AykHHBo3F5MeNChg9rTEcfgZEkDAQswF18Ad/UrJvhKWqBnulTj2SNb+T90TcWLcNLzIhMsQ6m1XU8TjMtuXdmvkhIIz5CNMgZX/HRTsf0Flr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759170072; c=relaxed/simple;
	bh=YtEAn6CmDr27aj5SF5YUmQQCee6wbRGfkRsR46WrjSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z44M0GwuoxWaX7tjpdTR6WcktZJ/i0N7RFbXWVAd8D+Oxc3cb6ivI2+fOT+g1CUMt2ADzNpDhUz32jf/QljFa3g0vh77gNEvPs2GSDxK8k1CDUXteFk5Jp1VPz2NrrKcZ1/8hSB4VH9aV/eKPzYNvuJ4rTtkFsAMOLCGSiXQ+d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cedQlwuy; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-816ac9f9507so619891985a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759170070; x=1759774870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtEAn6CmDr27aj5SF5YUmQQCee6wbRGfkRsR46WrjSo=;
        b=cedQlwuy74WC1aJ3/axAPb2Q7UDVwIZY//pM3PjhkKhHVo5tdjPCkJQLDMBMwYbB3V
         dw3VbR++bAT7T6jZPZ1i5Yh87Cnr1LNNTrHeFABY0np0WSUAHCzMeiTDQbZAA54eBDJB
         Eoyf1LBEkwRZ+VPA9VzelPCwHevNN4wea7ztfEBrX48pL0Ejui169aPSvenZFavZe3YT
         CfBOAuhdeGfD1PqR9FpcK5RrGUkmMrTljRtTi1/Kl2R7jJQ2hlKKsT0YA/4qpZnbsAtN
         aSHVH2VYYSCP3UySuC0f2FmC8T7N+loVcvkrMt2UperWP7LfZmK3Xml5RicPT/Uipi6/
         sYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759170070; x=1759774870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtEAn6CmDr27aj5SF5YUmQQCee6wbRGfkRsR46WrjSo=;
        b=TKoRK52pg7xkkQqBE8RB3oJpo2lFL89AGz4cZ15w0tzW3OEXVuPmgsPHSdMRLjqt8p
         X2c6QA+ZKZlasf65xM6ulKgJXu0PhNcBcKjl6k67jGJpFoZ2vK5fsW57EniqQKX+x1iX
         atp/Ow6IA8qDJ2s9FxNX3hG2XioEwwuGoGV2+y33iQP3bw/B8Zayf4fIedNqJREcF76Y
         yOy/VWY3afSG1WxspEStwxvWBp+ZbZzZLzJ4qYULSpUhC/iARF02SwS8gMusT52nmeuG
         W/SKmwZRBqGht3ldtnuCl7hM2Xh40n7huWeR4nE4DwqeLChyo/EyDsLlq52TewMblKTO
         I1kQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3Kxu8iC3thxxU5ZAES9/tB33UEoJye9WF0PhBdpBdw5lAiUWU6y0z5PGaZth7Z7XesrEGN0FMy2ussSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YygzLN6ci5lm73ktZaQ23lLp3/XPJ70tooQtSVTJxEmUzKOGGyQ
	cWttC0p5RuZWuqUrOImsEKfpgb44uZy9cApmXxMiXn/YjzQjl1XKnAGIOWgBIwu3eZs+eyyqw02
	l4hCi1ePI+LoM1AFg1LNA3xX6w6LePRo=
X-Gm-Gg: ASbGncs5WGFtWoxMNmlpo4uf2bb9gGMb9HeZXWAqhLtegnnMMb1gP0MpUWVGlD19+yL
	wiNqeAc1p6WDi46zB9gqeTcbXrFCgi+uy1BlI1oZBIC4UZJ8TvtNHTU9nupRSZcdpmeLKcC+UBq
	M+B6M/6vWIDhMGggO2f6FnAj1xBX935atnKH1bjqwJJzh9YNl5bOKx8rtlhR4gWLxkjHFr0EkDk
	Ao8zJF+
X-Google-Smtp-Source: AGHT+IFrBeJSgMsR3HaccN16cnXjcttv9tgaaLMJKzDwaIqr0lNEmWSIpPm9V69kQrLev4/WKIw2zOmNYU6wfZ7+6Po=
X-Received: by 2002:a05:6214:2625:b0:78e:5985:92f1 with SMTP id
 6a1803df08f44-869973a156fmr24287356d6.11.1759170069962; Mon, 29 Sep 2025
 11:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929065714.27741-1-jjm2473@gmail.com> <20250929065714.27741-3-jjm2473@gmail.com>
 <5700676.tIAgqjz4sF@phil>
In-Reply-To: <5700676.tIAgqjz4sF@phil>
From: jjm2473 <jjm2473@gmail.com>
Date: Tue, 30 Sep 2025 02:20:57 +0800
X-Gm-Features: AS18NWBViMs8caAfXLXKamwDlPSJ-YJ_sCg4Ny2_8taIjH_4vuLBQ4TYDgmLkh0
Message-ID: <CAP_9mL6e8ekL14xycSfPmVSkL7pANLeyewWd=rjxbtMgMQXxxw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: arm: rockchip: Add LinkEase EasePi R1
To: Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	quentin.schulz@cherry.de, kever.yang@rock-chips.com, naoki@radxa.com, 
	honyuenkwun@gmail.com, inindev@gmail.com, ivan8215145640@gmail.com, 
	neil.armstrong@linaro.org, mani@kernel.org, dsimic@manjaro.org, 
	pbrobinson@gmail.com, alchark@gmail.com, didi.debian@cknow.org, 
	jbx6244@gmail.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Heiko Stuebner <heiko@sntech.de> =E4=BA=8E2025=E5=B9=B49=E6=9C=8829=E6=97=
=A5=E5=91=A8=E4=B8=80 20:28=E5=86=99=E9=81=93=EF=BC=9A
>
> Am Montag, 29. September 2025, 08:57:13 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb Liangbin Lian:
> > LinkEase EasePi R1 is a high-performance mini router based on RK3568.
> >
> > Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
>
> In v1 this patch received an
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>
>
>

In the next version, I will add 'Acked-by' to the commit message
and then run `git format-patch` to avoid missing it.

Thanks!

