Return-Path: <linux-kernel+bounces-748530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B838BB14247
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06893ACFF4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96EC276047;
	Mon, 28 Jul 2025 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Mt/MsJzi"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490EA21B1BC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753729100; cv=none; b=kyjiAT3CJcL+EeYlqA1CzOcF/ju/GM8yMXyj3mzKeY0PaVeCgV5m2KgswSI4d+jyebY83FAUfURbKosskYdhpibYE2tfFYt76LuIerYy3dZ1OdnbwmI5I93ZzASW+bWxp0BpSJ6kDZZL9jGT2ivMofIpJk4xwmUVciSeZGpBWoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753729100; c=relaxed/simple;
	bh=b69OQ4wKYJyVOZsCUGDVDJDFnEpUIuYLCjyPVGv9y1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXeYkJZMrszZSYDTiYG4FqRxEV3BfrWVdI4SagZRNCeBlW8YCtISS3Er7EYr6ILB2j5aWSr5IpQHoqgwVM5+SYWM9vrALAaQf7YQRi8QLJWJi20EyM/aLQV69k0ptetRtoXKKAn5CVIFq9GHzqLsKYAwqBgyLLRkpuuHUy1Ao8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Mt/MsJzi; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61543f03958so1629767a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 11:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753729096; x=1754333896; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1B0VGPq5i+53ouXuQcjcdmGDSUZMS/bOyjuy32IMYoc=;
        b=Mt/MsJzicGzmnAyE4PV58CgTjJaMNpfLTVYUjbu5Z4LP+R9e2YiqBlog7uHRH+YlDg
         0BoXwC2rTX3nrdHUOarfBwCo2PhlCi+6xxLhIC0I7hNV+P6vZbEUKQENLkXfhMZYoVGq
         BgmJnn/DdMs/lMWs00hOJyR3z0LKW0JewiE88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753729096; x=1754333896;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1B0VGPq5i+53ouXuQcjcdmGDSUZMS/bOyjuy32IMYoc=;
        b=TASJJIw5SnSMKBluPiQrYrco7UbSy0A5S+6VCqcxGcJei9GYqYPXAqSi+dqe7h920x
         aFqTwCpjPafGX9W+BzOpuTSABUWQESYHc84xNTCN7L9UTrSW5O9o0UP4TivnUlcI4iMN
         syfgJs2VFP7J+sn8uI5j+qZMsCWV28Jr+tZWwB56GMvsheBRIu8fViBUcslBq7/tLNPB
         cZIYZc05rGQrdYZynWmq4hSxFVrakBQACtHUq/uvdDlV3i2CbdBxs/ouVPGjnsdHZbWY
         /IQP54XLo0PHSX022ku9M5/VDRGE7Yepl9pIdAzN1z+eGqPYTlHWWBwg2A0vayp7SaKm
         efRg==
X-Forwarded-Encrypted: i=1; AJvYcCXxirPAxQNj6nrhAn+RpHy1iKnBCElpj42I7tjPH53xYahJWNSBMK2jhw2Y5d8phyOr8fod9Du2bW+Ev5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMPguHaYWZkzQERIaU2wom4lgW3CCl0hsj/7mXNmADiWo2uRSM
	S3pGVVzeuoazizTBPqjIbolIJv5RAQQS1TG8Im3zv3NtYoAehd4N5BehW8tMZ3tlpYigMj3lOgZ
	zK1if5Vo=
X-Gm-Gg: ASbGncsUKijpyHyUlUgsTWXl3M+60uKRu6rgAN8rDI+7KBhgWH0MYN377LDzNsrbcbw
	3uT5QonMA/G43eLWTYupQBgTh0kvYKlJqYlkfIRs9hWxQBtTXFIbi11Roip0BMFii/nAB0K70Ip
	RkkejTK61aV06fLU7tIMAZAcxu0vuBv9rYpLeD3qbaSd5UFc3djGg4ri6e0rX7ITPFbeMRgRxI/
	l+Ci9Ee5kCgPLpPbvmGeIbHI7aOIvcLYWz1cERwg7a+aYjIxzTj5V8kSi4RwRx+QXLBNjNSqkpu
	s8Un2RfYlpfqo4EvYzKXnbDMlWpPA7SDwuhaXa4RUrkp7coCC6e6gN+GDg1imKIPBvK8wkv+PVW
	YjOVv8TU/wGZ8hhkZaq7uDIBMC7ApHxbETUB7HTRUEoGL4xA+zRk+0uCK1Kc9dH83ofHEsj/1
X-Google-Smtp-Source: AGHT+IGPep8T7X3Rvw62/IVMkda3tnz+7XVczI/O3sXIn0AWldD43OKrhFMxyiNL4IQoXo1owtT0GA==
X-Received: by 2002:a05:6402:42d4:b0:612:b9bf:2a56 with SMTP id 4fb4d7f45d1cf-614f1dd1445mr10773522a12.21.1753729096355;
        Mon, 28 Jul 2025 11:58:16 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615226558d3sm2638554a12.45.2025.07.28.11.58.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 11:58:15 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61543f03958so1629726a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 11:58:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYqZxVbvoIithPYpIwJ37EoqcD0lBKpk1/smmavFAnMzen9rADRtGbnAcjEaQPakMzPB4TRLSOuDY4t94=@vger.kernel.org
X-Received: by 2002:a05:6402:27ca:b0:615:5563:54aa with SMTP id
 4fb4d7f45d1cf-61555635846mr3198856a12.4.1753729095195; Mon, 28 Jul 2025
 11:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner> <20250725-vfs-coredump-6c7c0c4edd03@brauner>
In-Reply-To: <20250725-vfs-coredump-6c7c0c4edd03@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 28 Jul 2025 11:57:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=whYAT=9kUrGRCW=kWkF7aPdvcAYUnUj3f-baMy1+DsoOQ@mail.gmail.com>
X-Gm-Features: Ac12FXwhEsA5DQB-XZIHN4Bhc1mc1jqfEZkS-B95UcGNtGZOCJCseOEXBvpnfZ8
Message-ID: <CAHk-=whYAT=9kUrGRCW=kWkF7aPdvcAYUnUj3f-baMy1+DsoOQ@mail.gmail.com>
Subject: Re: [GIT PULL 02/14 for v6.17] vfs coredump
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Jul 2025 at 04:27, Christian Brauner <brauner@kernel.org> wrote:
>
> This will have a merge conflict with mainline that can be resolved as follows:

Bah. Mine looks very different, but the end result should be the same.
I just made that final 'read()' match the same failure pattern as the
other parts of the test.

Holler if I screwed up.

            Linus

