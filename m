Return-Path: <linux-kernel+bounces-794979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A47B3EB5C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334C917CA2E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D668270551;
	Mon,  1 Sep 2025 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="fnG+UTrD"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AA432F76B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756741465; cv=none; b=dNlw/96fXOnvessF//iJHClYy0WqE7qLhZdZs8aK3uZp8AHxM67Pv1ijcwMEfmt0NUKyNGg9kOSC4d+dqVSw9fXmOtOCdT++cR6SVUjiz9akOjICRdbttSgJit8mxo/jKyWrQLI2PH3ZOhSNwQR3JS+WlN3XH7JjkdbUJ2VJyQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756741465; c=relaxed/simple;
	bh=SlFTiF84cgj//wbn0koUdjPLm1AxeeZRg97sGsQJaVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8sot0c+1dAMQ9/P4Bth1NwaaelRpMfcKkq1hgG3wmm7Pl/fh9cgWjilJ24vrvRJFjK/TAtJMYhFpynJnBdUHaKYMoVoh5ch78AM0VJ0XiclsDFlz8VakPu40HJ3VIKM0b3BhIYzCkyQ6CNoFWrqeiXz2myiY51neAf5gN4PACQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b=fnG+UTrD; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e989adfefeaso2694690276.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 08:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1756741463; x=1757346263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gv8Fs1lCORqoKvCxwSJ1PHBV0IJT6OUFz2w3OLpOTgo=;
        b=fnG+UTrDw3bInIW6R5FFhfbVENrXz2O73Mjhxc8VikrCGnnOQ91/TZ/XihwepzoGhG
         nObAb8sTkPiJ19RzKtHW7JCyGAq3dFzf58qKJZXc+Ycpd1bbE/i6sb9lhIQAOJV1hOqg
         q2LLKbR+ex0KgnPbsY/1xiZhZbN3ppuhu67SH/HLbwqWQHyqV+2IVb6Y2omfd2IUfVLY
         BiC7BQyNg++Bqs0gyBJwsJMlXVyQn1Z+T5kYY68h6I+j2wibyumyFbW9Jt/Ez1XuUpeL
         zkFS4lu4GRM4eIBYve7/dZCIQReX1uoq20D5GOsbWZo7AxkP0c4b5bH6eCgIaNgciaqZ
         Jxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756741463; x=1757346263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gv8Fs1lCORqoKvCxwSJ1PHBV0IJT6OUFz2w3OLpOTgo=;
        b=gA4X8o6LlMie0+rtbot4vPGPTTh2kKkiIjln9VZSibRnzb5A2vyyYewHhlR83hBJfR
         xWF34LxKJC7zyDIgHxKIuGCcvcR9l1OKVjoGSj02d8gmNuSdf9+b08o4sApblie5HPzA
         I2nl3f1kFJ3WiQA1vCJtPpbrnwZUV9UvscA5rhyxRAjPA3tipOSIIB1uU1+zpYpgEVQl
         lcpwtnI00TSptIC+8CieJrIWUIlNY4hE08Tls7ep65HpXYjZ0v0woO9ZD8m826tx/J8N
         Qx/xCEJKhcZzeDiXTkCvlsI7OOj/xgzajWIP2JmO7gk+MTKBtGKt7l9SstrLK74twO2d
         BVXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHM+4H3UtbsomLz8lYOp5CykCyLlf627DYuep/uArhD8e8TFZzYn9RVdMImrnLRFrk7lIgXFFKIy+IUKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDrcvtPLuN7rmR4xDZc8iuhpKGhXmmEbGyqA3M/l9v+GLDkgbU
	Edw6oW0D9x8uGKqR6CLl0TZi2KkSgpASg2tFui1KvDtboFcXF9mANH8cSQmjPQk1I5/zcQf3Fi5
	PdAG4MMaQ2A==
X-Gm-Gg: ASbGncu102ULMN8VXG8a1SOpajrsXefF6fpJv0mqWM3rl5wF0DslFZ96KwVamh01jDh
	EAJWP/g0T/xz3k/uMJVLjp8X6GHuGHF8gl96oFotp504Eb44SwIP5s9/S7vMZ/Vq96dNekxHyPq
	NpjVwbDrYkii1CSj/YzA3vapLDC3lKJc6lPVgEpOABqIccrg92mfSTjb2hCVHqUOHKDHiTXtMZP
	1e+WvqFu+rUbpC1BdnUAe6WSZ2PPC1V+Vp2Rd0ZK9ehywXZiaMTWYqTfGfYFHmZl5UgGfhWN+Xm
	bqiiOkyokLQTynQlhgDz83N6YNNJrbcewllMXmLQalC6m33S/6Fg9okblB8uineJHTASwapm3mC
	BIfGX1ZfCED0XcV94D16tx5SUJrGKLDNearMO2lo/Dnjpk942Hvs5RslmBUKo1RxN0g==
X-Google-Smtp-Source: AGHT+IGsI66c7iUq/zk0bdetHAFdf6eWhia9OwqGYQFnu2vdC9zxT+t4VRB7nsYMx8V48CvXfMekiA==
X-Received: by 2002:a05:690c:5085:b0:71f:f726:50aa with SMTP id 00721157ae682-722765006b7mr77606057b3.33.1756741463191;
        Mon, 01 Sep 2025 08:44:23 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7227d67377esm15461187b3.33.2025.09.01.08.44.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 08:44:22 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e96e3094fd9so3899371276.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 08:44:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXkIoOfXeh/9nLCIOvOH8NF89R2Xz9pN5GwcM2miup9xypSTqpWKEEBTjutCh86o40mu0B8TBC+j5gQ2PM=@vger.kernel.org
X-Received: by 2002:a05:690c:6903:b0:721:40df:7383 with SMTP id
 00721157ae682-7227655ae4fmr106570827b3.41.1756741462296; Mon, 01 Sep 2025
 08:44:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814113519.1551855-1-heiko@sntech.de>
In-Reply-To: <20250814113519.1551855-1-heiko@sntech.de>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Mon, 1 Sep 2025 17:44:10 +0200
X-Gmail-Original-Message-ID: <CAAObsKBZ7rRXv2JmmLO9PKvMY+KLuD2v8zhLYL9_StdaKgyOyQ@mail.gmail.com>
X-Gm-Features: Ac12FXwcbnQZ_C4li99eU8OMsQt941Fs8LXnbtlzUm57hljet67PvO5cNNPHidE
Message-ID: <CAAObsKBZ7rRXv2JmmLO9PKvMY+KLuD2v8zhLYL9_StdaKgyOyQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Rocket Kconfig fixes
To: Heiko Stuebner <heiko@sntech.de>
Cc: ogabbay@kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Heiko, I have applied them to drm-misc-next.

Regards,

Tomeu

On Thu, Aug 14, 2025 at 1:35=E2=80=AFPM Heiko Stuebner <heiko@sntech.de> wr=
ote:
>
> More common indentation and depending on the actual accel framework.
>
> Heiko Stuebner (2):
>   accel/rocket: Fix indentation of Kconfig entry
>   accel/rocket: Depend on DRM_ACCEL not just DRM
>
>  drivers/accel/rocket/Kconfig | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> --
> 2.47.2
>

