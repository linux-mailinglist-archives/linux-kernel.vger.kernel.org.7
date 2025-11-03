Return-Path: <linux-kernel+bounces-883399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7C6C2D551
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B09189D6BD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E781531AF22;
	Mon,  3 Nov 2025 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ogQRM1RI"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCFC3164B7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189212; cv=none; b=e8jRUqc1et+NRZv70fQuPnqxzOvO+c53ii945fOKPDBHdldyTpJoXPj20Dd2YUvl5BG1uJ/sSFSCJLAbZOMd42rtELhW7o2BjIg4i0NTo2vTvr5YlLJBx1Myeglat1BLi67bIdSqs6ixw0Yh/8bnns+GshEdAWrghoMJynEq0YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189212; c=relaxed/simple;
	bh=bxgI7xm+IgIVGvsbKQgVxrFpU5UPoucGihmhUKxnDx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t45kL7HgUAgSufnkGrN6tVTPyowd1WN7F0S3XAtgc/c6HcvGI9ArTL4/9mHNYDfNF1/lBvH3k2FN40Z4QpCLtUEyr9ipQp/06nPH/4BhCup+YIjicvDtmOjiex97uQacaRd+SBWMlVxS785El8BatRX9UDpey1/VfyEiUsHDCHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ogQRM1RI; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-378d50e1c82so44492051fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762189209; x=1762794009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoNdC5BMiRyOC0JiGM2ExKgLEDkWaHJnqqKpzjHUJnc=;
        b=ogQRM1RIDauUxKdDMF0xVOh0FavrKXs/i4GjeTjsRvuc+GbOQ7Eq1VmdRVUFiqkZuO
         mTaM0ABhs1BSs6NypX7y4kkvj2aqiSdz5NcIKowKDlYnQ2kyjLE/HuCG6GzMbldGtJAh
         Rmh6hBZ5XjRd3HnatSG4//IMx+NR1HXKpdnM46qs2dLYyh7E/Pi/jiAgMiUEYcoMidaS
         LWUiKgDuL5JfOzt1/5+9Hx/Ftz7ZzKFyEGP8bnIFQZLyRujj9UGvmU+rQvzlHJUkTqmN
         4lGwBM29w54J/aYumPsumBkL00sl1fARjKJwLFJisN+K14rCyXx9Or9m40MGWoUK9Tzr
         KG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762189209; x=1762794009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WoNdC5BMiRyOC0JiGM2ExKgLEDkWaHJnqqKpzjHUJnc=;
        b=EaYuREehaPCqej6L2LxMAzeRkbWLqJ9NagBwl1G5974t6G5MF6sKEnsFOX46C3bAJn
         WRGLFh/jSFPhRXk/Q2xczeWw0UWugXWWkZyvhuql7QZtAVAvUzYXhBTRLIs2w1o/eSmt
         4saau3P4NMilsaEo4NFB137Sx5u6Y3EppSwqf6iZcOo51ZftJnpuOQC7LlU2zxoOki9e
         lxul7NvFDrWqFG8y3S28qbznNq2o04xL+SYn2UtFZCK/5hgH3BW9HdARjzQasJtuLFZW
         /1/uQkdoUwDPXe8tWRu1csFkk1jEBtoKH/C+0KcXoDXDmMvUYFMSG5//m3YIhC9cGkl8
         674Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjTVUodkF66rq23upKxbBZcgbLnbcNduPYjpzGGc7TVCWp4svpz53pJYeRlCss9/sYLM/5QfgrenbpZmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw50xrxJpgA3CO9i7MK8PbsmIpbe9zR+dx6h1pNk/9XJEuwBC2Q
	VwTaQ+Aabg7jBXxYBMvmogMoR75w2dhqDUllrpzNpa13UFtTPlsuCXo4wLpJ4WCaPaTB0Sn/Iyf
	jzcI0wbY2MsRbFR9q9IwFnY/JSA8F/WJzjxnCPQ9uZA==
X-Gm-Gg: ASbGncv7jw4sIM2U/pv691eZX8hWzFOxSzSvTsbS2K4qQ3xd5dSysUroZSBxAGWYgfQ
	I+WoRoZIfV2+6urMwkZPk5LW/qB0anzzpRfxGveyjma6VJ58CSEJtKhoyGL3cXf98iEaaxelZ5+
	kcQEicggl+jje76kltrFeOf4EffkVwtnS6C2BMqP2I3ol2UdSJBEVtAEzCdv9jDsLdHPr4xZsRl
	YsYhIhoAT6B3gKMva2qPN8lbjzTFykv7IFrHgLHw0IWsMc6KHq/mpFA9GqTVXlMaoVRk6TZFW8W
	MGBUUsFyjQNsyfSwfAS73yJWv+s=
X-Google-Smtp-Source: AGHT+IFAokWDp529X/xQj865heioyoJ+JqIPsFe9otddKohP4c/QuEQTPtIBaIp16NtEOgDGZnEZx9kzQeL+ZIUR0So=
X-Received: by 2002:a05:651c:2210:b0:37a:39c1:721e with SMTP id
 38308e7fff4ca-37a39c178d0mr8876841fa.17.1762189208387; Mon, 03 Nov 2025
 09:00:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102-multi_waitq_scm-v8-0-d71ee7b93b62@oss.qualcomm.com>
 <20251102-multi_waitq_scm-v8-2-d71ee7b93b62@oss.qualcomm.com>
 <CAMRc=Mfh+WQx-vasZed6jWi5nUjg=K+ScVRBMCiFgK397=JbVg@mail.gmail.com> <da04aa57-f3dc-9bcd-5ba3-05088a6661ab@oss.qualcomm.com>
In-Reply-To: <da04aa57-f3dc-9bcd-5ba3-05088a6661ab@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 3 Nov 2025 17:59:55 +0100
X-Gm-Features: AWmQ_bmXS4BEImKKjWCHGw5hmxlPJzmWjlXp6Ll6_YqBi7myoVjDaXfXIpxoD70
Message-ID: <CAMRc=Mcj_6g3ory9zqxEWCHmpxh3hf4C-iBK0XT82F8nGVcFKQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] firmware: qcom_scm: Support multiple waitq contexts
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Unnathi Chalicheemala <unnathi.chalicheemala@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 5:16=E2=80=AFPM Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> wrote:
>
> >> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/=
qcom_scm.c
> >> index 28979f95e51fbee94b84c1570a4d88a76f72db4e..0b6efa7c2bdc25a3ba152c=
25d5451d1154779ddd 100644
> >> --- a/drivers/firmware/qcom/qcom_scm.c
> >> +++ b/drivers/firmware/qcom/qcom_scm.c
> >> @@ -47,7 +47,7 @@ struct qcom_scm {
> >>         struct clk *iface_clk;
> >>         struct clk *bus_clk;
> >>         struct icc_path *path;
> >> -       struct completion waitq_comp;
> >> +       struct completion *waitq;
> >
> > Why this change? This makes the name less descriptive if not misleading=
.
>
> Want to make it dynamic array of waitq`s. Should the name be kept as
> struct completion *waitq_comp; ?
>

Yeah, can me waitq_comps if it's plural.

Bart

