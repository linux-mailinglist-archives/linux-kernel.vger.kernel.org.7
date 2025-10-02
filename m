Return-Path: <linux-kernel+bounces-840705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17008BB5077
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 21:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30CF192172C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 19:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14829287249;
	Thu,  2 Oct 2025 19:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VJUOe1ti"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22D4286421
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 19:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759434144; cv=none; b=smOihfK3qmODnn269k9I9Is/wEpd+5m/xmegSZ0ta53ZyZUprpf9qutuKcBhZ/jYkb8iobKqSZsjP+tvXF83OsI7ASDqX01gTQ/aJ7ZxnU+Px8QtjR85GTBzM9be/f1LY5CQunAXm4nxMALiuJ0lRYCAbH+BNOhtEe8betKu3TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759434144; c=relaxed/simple;
	bh=Q/IteUfsdc9uXa9k4p1PZg6c341HQK2Ae1qCvKmOoEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FODx5S3pxAEC3bvY87gQMgN08ItHJbnQ2XQcQ4ZQ15XhsB3GLeh5toAX67kXGa0nyhMfeNC1qtwC2AZ8huVr1dY8a+j9YxFAoZMz/psRokA4ccJjyjrGXuF43XM7gSOmA8B6swVeJpqdnZaHXKOJPz2B5DfrYZP9CoqLHeZWxW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VJUOe1ti; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee1381b835so1208771f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 12:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759434141; x=1760038941; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/IteUfsdc9uXa9k4p1PZg6c341HQK2Ae1qCvKmOoEE=;
        b=VJUOe1tinovVzzJ1JxZVlQZzsP0SrMY2KWUyi1iZ57Nr/W2scHWOj8DKgVTvLXwNhM
         RnrWGgSH7Jy/5oyylmDFwO4ajzWkcCPWSjCD2hwhjBPkuepxVPY9tHu6JCexCNRKFKii
         RSx1HBya1vvQ+2ZKgYyTfaMkxEM1F5tN/EMTjMVpKEXIuI1lq6SfT8lK8C3wC/vKy+C/
         fW9EsnTh5FVRSR6KTr0lRehRwBSzAmOZPVfAT20wC3gg0w9v6+jwnHQHQH28eGUqGeHW
         c/6PCJVaFHUGHm13sBn+fb8Yn25RaPMRifiVb/KodWs5BkQ3nIqxw4RK/+sOnQgJCDKO
         0Stg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759434141; x=1760038941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/IteUfsdc9uXa9k4p1PZg6c341HQK2Ae1qCvKmOoEE=;
        b=mTvJW2YVvFpSTO/Z/olxViXVLv+YEE18hCepHSGDdLlB7ac3Nb+Xj3CMW0g95pdBIx
         OrRJRRLz2eem00OFibFTqDHmK/ivnGjIhlG/FW+0VDhVpKvdvhG3L38nWnMckoNREi/p
         YRHXtot2N0dqUBDj6DRCSHENXc4wW+l29UYTTqQCtD+S9+qNusDezIHi71rbODEkq5+C
         U8cslLjuIPWdqE0j97w+wcFQ9zVLyEGqb3nb3t6OoA4GJcd0CtNTse8NdMUZfbRrGxU3
         L4N1p6Paj7Evk2Bc6nH0vVyeJ+qIQB4l3pk16WSNMgQywyj6tMMEZG0dik3WesYv51b2
         R28Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMhgGUBBF2Le5rn4NZL5k6Lp3lGN1ZeoBTgPvdK99QwSVKuArvqAOsNwfqqp6IvGcy2E43a91IBS1yjbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrPN+h5lu5Cl8YTVefBhiIEUGIEfsMV4fIFZV+0tAhJolAjs/e
	NXR/Vl46Wx2WGu6tw9N7MaUtW+atAOTsOC/JwlnPA+6CJBMj+cWn0HYv0JNbNh0m0zKY2C8Hr1N
	nfadFdrwE7sbQKGQ0Mjyab/5WFniQjnHD6HsuDny/
X-Gm-Gg: ASbGnctF/m1NY9+e6Ir/3ZgaVtKm8DcaOSyrouwcCMFzrKBFX/4m6D1AtlgppAdGSrR
	RuelB0oa2/9abEI/Ygl/kVT4uuXStTWjcLsLKDgXUvnRysCaFbeyD/cMIHxpBfDy+qarN8ee+JW
	mzyt+ClFpQl/VIAg+PrqKpIaQKt435kw2+zwsebdBeB6ApMKw8jiJ+qxsxQFObedz9Lkn5/ZMul
	cuTNbO+ztg6msQr/4K6n3FQlAWhLiWyEW1mynVfB/ckwwZ+iUaZSw7mxzLcTety8Mb9
X-Google-Smtp-Source: AGHT+IGAzqI9zShvLUg4thsYZhAmQ3tJF1bhTlEa520l2RtxLRAkBSidqGUNoP4V3f1Wg0ZKuzlvehV00EMnag8jrAY=
X-Received: by 2002:a05:6000:4027:b0:3d1:c805:81e with SMTP id
 ffacd0b85a97d-4256713628amr300032f8f.4.1759434140951; Thu, 02 Oct 2025
 12:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926202234.3064386-1-jthies@google.com> <aN5iyOsHILi40AIp@tzungbi-laptop>
In-Reply-To: <aN5iyOsHILi40AIp@tzungbi-laptop>
From: Jameson Thies <jthies@google.com>
Date: Thu, 2 Oct 2025 12:42:09 -0700
X-Gm-Features: AS18NWB79j0oFxpI_7gQo4UjXbQOPDnxSZuY-zTqaDlZ-r3GhEI_kvhpY4NRVUY
Message-ID: <CAMFSAReHEt7nUZvsnB5pyPTaddSVSdtiiX-RLpY4MfKq3qfX1Q@mail.gmail.com>
Subject: Re: [PATCH v1] platform/chrome: cros_usbpd_notify: defer probe when
 parent EC driver isn't ready
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: akuchynski@chromium.org, bleung@chromium.org, abhishekpandit@chromium.org, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > +#define CREC_DRV_NAME "GOOG0004"
>
> What does CREC stand for?

CrOS EC. "CREC" is the device name used in the ACPI definition for GOOG0004.

>
> Does it make more sense to use fwnode_get_parent()?

I was initially planning to use fwnode_get_parent(), but calling that
from cros_usbpd_notify.c would require an ABI update to build for
android.

