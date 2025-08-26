Return-Path: <linux-kernel+bounces-787166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1FBB3724F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69BBE4E24A9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF216370580;
	Tue, 26 Aug 2025 18:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4np88ZLg"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62662F0C50
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756233538; cv=none; b=G1TMEbpPv0oNS3fLaoDyzIU63GkZ+oy1NHARU6mu58SCMB1youcn3TsnuNV7ZN0EO1AzAewAtZiNZeV/FsUdgja2Ne8k65TTvm0ofPPobSUOMzPbY761ptDKSwwe44OS3GoQvPyOxgm0TJkjnHyhZiuSJt5sxuBjKi1GmuuHsdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756233538; c=relaxed/simple;
	bh=06jdW27mAIPRBmadC9Obk+RK34cpiAgXn9PuJx8myVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjD8oC9mLmHti09jQ71iwLwzW3a60dg02Z05Ot3oS9QxH1paeygcF4ssBZKn9Xf2TT1S9PcV3r9pBna/Pmb2ShKM27gsqXepbqf95rsND5FMoWCGZ97nU9Fc6YVzW4Sykqo9TUEvItAhoF/QGA04GA3Tu/X1grYaSecijlrYWVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4np88ZLg; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b47174beb13so4124035a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756233536; x=1756838336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06jdW27mAIPRBmadC9Obk+RK34cpiAgXn9PuJx8myVg=;
        b=4np88ZLgYd03qQc+6huSoWZ8qYhBXOmi2/meJB6jH5nRw7LvpYZViOacMFrunlUhkg
         Dz0I/Zg2JfZ/Ydk9obh57WNifbkMxudPbptJg+UYLZQz9LyJIBdkpDBh0fnXFGMgHpRc
         Njv1ItWVxux541lA72eSzs63HzjXMYwplpcCDQZNnmLdDk+LluwjusnFDeukVDtt9Hd6
         jNNhu/1bQDx8Mi5YtELcQA0XFeZ0q1rg4cz+WlV6Wto4rScR/JR3pxVjUuOuKJ4cSO1P
         rMAf4ATPqkCbpcn0lrjuUDj2sisX29um2ig9Rr3SvSVcGEtqHnNxnVGkEUuSlsrsNZbV
         KBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756233536; x=1756838336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06jdW27mAIPRBmadC9Obk+RK34cpiAgXn9PuJx8myVg=;
        b=tGdXQluQEZot24Y199r8pjil7jupzCjsipMCR+JNbjY1yfJZMzypE01tHeXXGbzksM
         XuA3Jqj3x0CSgp8bNbLHu9VbYXhlgD+3zAE/iQuCWtyC8Q1cpjdTNN2FWna0CTLWW83M
         WO/N//zT+DZNUnDDGSeoNaL5YSyelNz/OuvIVL9spU2STNWcwAzzGNm9YS/+fqT0+e3f
         2jgyyr3dtpxaEJTXlowXrRi7UC4aSXaeTtWh1qUzGW0eQfwqbFrUbSrOWJkKc9/hHuwt
         I+xQUxHrkexEiNKz4bR6ZPxDZfYRjFZycZQYIBfrQfLg+7yUeZPuIur1/R1emBBvHOLP
         9QAw==
X-Forwarded-Encrypted: i=1; AJvYcCV1vlfVp+ysRyT9Iw8yqMDGBoX6JFdaLUMJfzjWQq7DMj5TSl9YuxQUerFTXNz6PwJydipkRyDugO2jb1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1XLk1XXnHKh43ZocyENT2bcj0SSl2H6IoXUWvafPGXD27df/Z
	3zN8RI2uAWFewOAUlyd33K0ujO5Sw/AdTDVxYxaQDO3JkbyEQ4t02M4+hwJ2RanKfgeuGvgCSf1
	Xv61H1srztiQga98pBsaCnKt4uYVTXIegeYRw2y7D3E9g+uGLA16VI4QOV8A=
X-Gm-Gg: ASbGnctsSl6x0l0GkIYUnkmvcdEmByAUgdaU4xFk2vqDBqWv6uCpmvwzqL3j7Ur44e5
	hgXVZnaEV8UbvI9Oz58Gyw28I/Xli0qjOIVjOULw1i7qhpVU0MiBo5HmaezeZHSURKHXso9bczv
	0ZKDtDHDhPHqMXR4rk7kBWwwgs+x+vMQIIUX7SG9Cs8GXQN82A9qTwsuiXEL5kNsdd1W33Mil6V
	pxEk365VZfI2YR4cVpo3qxEX8DHkgxi7KESvfygpb0AwnLFWOBLKA==
X-Google-Smtp-Source: AGHT+IH5KjEJVhvCkQSabMFJ6Dgae7xyjx92todBEtX1cQ3584ZTM1rL7jIKPVZvYFP3E0VQrG7UKBtxiwCnzhW7MZo=
X-Received: by 2002:a17:902:e946:b0:246:461b:d46b with SMTP id
 d9443c01a7336-246461bdafamr192188235ad.46.1756233535777; Tue, 26 Aug 2025
 11:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826150826.11096-1-ryanzhou54@gmail.com>
In-Reply-To: <20250826150826.11096-1-ryanzhou54@gmail.com>
From: Roy Luo <royluo@google.com>
Date: Tue, 26 Aug 2025 11:38:19 -0700
X-Gm-Features: Ac12FXziHtS4dfDITSUW9py7_9gScCCwvZ_1Krem7Oi7XWBIDVeE6StLiWQj7w0
Message-ID: <CA+zupgwnbt=5Oh28Chco=YNt9WwKzi2J+0hQ04nqyZG_7WUAYg@mail.gmail.com>
Subject: Re: [PATCH] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
To: Ryan Zhou <ryanzhou54@gmail.com>
Cc: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 8:12=E2=80=AFAM Ryan Zhou <ryanzhou54@gmail.com> wr=
ote:
>
> Issue description:
> The parent device dwc3_glue has runtime PM enabled and is in the
> runtime suspended state. The system enters the deep sleep process
> but is interrupted by another task. When resuming dwc3,
> console outputs the log 'runtime PM trying to activate child device
> xxx.dwc3 but parent is not active'.
>

Wouldn't the parent glue dev already resume before resuming the child dwc3?
Why would 'runtime PM trying to activate child device xxx.dwc3 but parent i=
s
not active' happen in the first place?
What is the glue driver that's being used here? Knowing what's being done i=
n
the glue driver pm callbacks would help in understanding the issue.

Regards,
Roy

