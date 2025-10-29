Return-Path: <linux-kernel+bounces-875850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1E9C19F3E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2CE0635499A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57153324B20;
	Wed, 29 Oct 2025 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="cNCyeeSy"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125C730C635
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736593; cv=none; b=uXWyY2MMnHOJL+/4xb2GIdQleXCV4medYlyZPTqgCTZOpkj4i9oRRxFnNdd1HKqdnHEEHMCFHn/0tjPg10vtyK4pTotFc0jVKhfCUkRUIApIp7PXf2Ooow5B7n87II4IHjrxqq1ur0H+qGtJ4efV8y/3aT0vYpV4D6wDESHP0yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736593; c=relaxed/simple;
	bh=xeF25thM2PZPH5jzTzq98NGYuyp2mVeCEN2oT8n+yjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkWvDO9GyVG/JvyZCEIDaFivQqJa4GcGjid86FGCzUnQrkM8bIsUXnX95LaxR7WLifoE1C1eYxYPaD0KU3f3FBcQM6d5ipUNlANnO9wgn53vF8lWvJpXVE/03idTRDWwfD5HRUmIyMD3bgMkgSR0oTie8SH1Twy/RJUQcfDBGe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=cNCyeeSy; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-592fd97c03eso6732131e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761736590; x=1762341390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xeF25thM2PZPH5jzTzq98NGYuyp2mVeCEN2oT8n+yjQ=;
        b=cNCyeeSy1c/ns/q2ev1M1GRICHpQxKU3b0FsCkG670ToMDntZwMdj0xQiE5v4fNqcg
         MMWjtjENHlbFgHbIalUWWaw97BBFsloJWhPGBPa+ywJF0ZtV6ai0YCIUpXfVdgktGDu5
         8agU3FMUyzEXO8EPq824YTnHkAmlJI7DG1/zHMyEOALP5SY6Kn/6C6Hz1LJ7UUcs2gFt
         9ubSzwZh2F7B+wg5xiaenquYpcKJ6oyrz1UIGaCS+McKsqIU+noZ2ToJDqp0/q4Y28Ht
         nlB+DsU+QAkVxOEQgAV7EZW+xw9CgbHIpsTjO0KOlW/hGeHMhChrElzuHJXUr+10ZdK3
         C6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761736590; x=1762341390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xeF25thM2PZPH5jzTzq98NGYuyp2mVeCEN2oT8n+yjQ=;
        b=LbQ9F/H2/OFQJHTBhz1rKYEJI6fiZFmPnHARY8WEIdHurrpEPKHv0nRYAW0mcYnShl
         HkfBY4019Ul8zOjIi+HpMrcrgSkFiE3XQnQeSaZUe7S+DVpDdVJA3mS8nNH+QPN6COZS
         PdJRp+5F2WfzyIjMIS4Y9zDwsR3ebHdruVmPJCofFO8GTmPP4X9iTm0nQotSpshj9//9
         JE0PE+4Wn/5LUkeCb63uERg8dNnOcPEck5ZSXhhV6MPBZywV37gUcMDRiwuxvm+3UP4s
         2zZQa3N3mMfhfyJHig9AZ2kg8/89/v3+8K1jb1DrD6NirTESbS4ZsALv3diT+uu92dRR
         v84Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHU8unRdPzXWx41KjmlY1iQFWMQgTnAY87A9BFZZZ+c+rB5xJS0tGlb0f5oEDe1lu8DO81pBalH/KYfwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYUE6LaTlckG+fmC0g5ovmIgR6NE2HFyDQ4bLlVzoRxeJvyNrd
	CTGWZQsacqiS9mQzuDBpzLpuh/h1XnsvZSDNilHoOX+nnTMLT1oe7WRVBHub+kgPxBne3d+rJV7
	FWVDlDm3iQhUymE8uyHDoMrrV8qpSW9GuMsndBpKGDYufNknkKc4EgcY=
X-Gm-Gg: ASbGncv3DmS5VlyxftDo/JZv37AiIW96BiPoILMSIYCZMdyNtmLqgq4czxZZ9qnJLoK
	FuV1kXhDFLuH0rPAuCAcqstAe8CG7sQ8/+EnLdGp9xHolvaAObOupLkwcxbP/fjRX11sQTFgIlW
	nJOXGSYx+aetVTwA/MvzXp/v9Bvve8hWcxwjaqPx96jIgbARAFgo6oKWUZVlMOADVETQ3SDa3rZ
	yjyeF51aZuq8/ddbVSodxtUP4kDAvl60MLIR59LWJgyyu8X9YNHl+lcJ9yFRjHDZr3esPzftZrW
	vqFlzOp4wg2AmUwb
X-Google-Smtp-Source: AGHT+IF/PPqVroPx/2tFULvtimKphv304ar6mv/wspGSpJtcnQw2H6jG9Ib/QTIpk1kNC5MMvSUh9nk2G1XqNVILan0=
X-Received: by 2002:a05:6512:234a:b0:55f:3e82:9c7f with SMTP id
 2adb3069b0e04-594128dc455mr1078602e87.51.1761736590136; Wed, 29 Oct 2025
 04:16:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029062050.4160517-1-raag.jadav@intel.com> <20251029062050.4160517-3-raag.jadav@intel.com>
In-Reply-To: <20251029062050.4160517-3-raag.jadav@intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 12:16:17 +0100
X-Gm-Features: AWmQ_bn6vqgzrVesD9W2JQVivGMWV4bU1ue1SAUFnBIzZij3ttVsyd0m_kSvm1E
Message-ID: <CAMRc=MdsF6VoKrHBgikMreS9LDNhdwMVRvr=TrM211O37YuFqw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] gpio: elkhartlake: Convert to auxiliary driver
To: Raag Jadav <raag.jadav@intel.com>
Cc: hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org, 
	platform-driver-x86@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 7:21=E2=80=AFAM Raag Jadav <raag.jadav@intel.com> w=
rote:
>
> Since PCI device should not be abusing platform device, MFD parent to
> platform child path is no longer being pursued for this driver. Convert
> it to auxiliary driver, which will be used by EHL PSE auxiliary device.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

