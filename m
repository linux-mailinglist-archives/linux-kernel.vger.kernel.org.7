Return-Path: <linux-kernel+bounces-867240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D9DC01FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1223AF9F2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05EF333452;
	Thu, 23 Oct 2025 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+uWeNry"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72401333742
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231637; cv=none; b=bMsYqa1IIEyOCyCtSOK6te/rMqRlEKBvLqNrI21TJoV/KO4+7S3RD/xXNSCwPOlaB7iHn/RuzBGT5CfQbNc3REW4iTTmVRXvP1xSymfbKI0WLXykrvyvE3wxn5V52NFHE3+MyEiKYe4XicUOLyoVGF7KStQreqoug/FAj6ORrk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231637; c=relaxed/simple;
	bh=EPTvx8s1xjF3tQm2xAcjvTwi2857pglx45RNhQja5kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dRsys3gOwC8BAW/ddhNBeLZBHwKB/vVs+6TPwScLtUMHyqXlQRWdwUYjHBl+M+0Lc53xFKlL01MgiIGPrxj6BWUTi3YLwnj0/mJw91/RGdyuikgCepHy4SoBBKilun8Bl7hCEv+vM4i9/bg4BDAGdK+bKW9fEiyGlhlwMKdGreY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+uWeNry; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so1074691a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761231635; x=1761836435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPTvx8s1xjF3tQm2xAcjvTwi2857pglx45RNhQja5kU=;
        b=C+uWeNryTmjDhfNqoaZqlV5UhvfttDlkcPH6mDmNeKO/uzlVfqti8xAqmDzu3UoJPv
         RS8xw2AdUxaywAm7fXehZuvE8l02o3wufFTujWb7tI6TTrFjKX39JKYYkI6kMXW3nqWQ
         deoatgxPdvnNyMEgdTZZR8N914WzYfMpcacC7nnVQx5AHTof09Baj7dhHsJHQoIgeL9x
         ROK0DPDJJ4FkIldinnbe3loSstW12CD7oZjy1Fza3muJqWnGHSubsFlXPa2qkRd+V9dn
         3iLayCd2wzqQeH2ggiB2QxnhM6MgqFqb8Vi7MA3OLJkMvvajtJk1oTgWWW+HFe9dhnbL
         hFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761231635; x=1761836435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPTvx8s1xjF3tQm2xAcjvTwi2857pglx45RNhQja5kU=;
        b=lnKWgeoS4nW6R4bgtXF13GfBfLw1waB9eMwQg7O5iOQdTni7Q7mK8BKdBZW1hdQFE8
         fUQiLW9OYALRgxHPculD9D+jeCoYfZ4Wn/FDQwY2CX9jVQkeygkaG1+QiXLtJNKIW+3A
         byK/h3sINAqNZAkXVNmF2fRBhrH3TD7xEK5M4GXy2oyR8VuAMGc7GE1swMvAmJb/ciqY
         3hL/VhB2uGj3HRLRqKW7eiuMpRc7uTSETTwinDNErLX6VqqVXzdh/3ZUwEj4CxnOIjNM
         U+hhCRF2rCXZdZ7eYCdSXrCG/G5Fm7T1y7/m+1DdebNJ9tCeNT+6G4WNEEvHcQrk0J25
         I0qw==
X-Forwarded-Encrypted: i=1; AJvYcCW9Lx7xU7WzvbupqpAvyMEHKa5HLRViOEyEutvBubM+BeD/yFWHRNl8vWc6mqo3RmUshfEaB2UBKH6JDsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnjE/oX1wQespbl0mr6WRRw03iguHNl5YW2b9FrTseUbWBT3/t
	igWJxDoq50OOnVG/caAfbcrFpLN4B/fwr0YsPj7NLREJmAKO4mxKDpR1
X-Gm-Gg: ASbGncvvxGLl+FgTcN3MaEd5aCNY9xSwQCNHGeaCMuJ5ocj2p2NIVpjIiiED7litxiN
	XB2ZSoctCpzBQ+EL4E3IYXhXXy9d53+A7Gs41EoLNFY7h0uGgCf3bTtP5ZknAGdgcmslnawQStc
	jd1rCD5IpBKJga0XnZyDl7EKZNHvBTHVsnGfabUuHUWpz5mo6P1KgGAMaZ0hzSI4qlJYs3991Im
	uP/+JBG4rghOd1TngwZU7vCg7eW5bH716c8mE8jn7Fp47tCI9wWMMQvkV0LMvSjgDwGkeynT+OX
	QIUhM/JEKUjSW9gfJ1xDR4MrC9+mT27ZwFekVkPtLLf8um+ffl41O9oqHvG4G8TkuTsw/wuZKSk
	ANYBA1xA5TvUSju9jkvkYLxVKuoKMozR5J3nUOlOZSEW6ehkC+FZ0PK6GqGU1subeeqjJPMKwYB
	iSHmisizQd4MOZZrtOhITcgn/Cb7fG
X-Google-Smtp-Source: AGHT+IHn4PZEKXYm1+7LvVn4UMOqVz90PtQ2psqXknB6QS8j2BPnoDTfZDXsRQz5Bj7sIQFcKZg0BQ==
X-Received: by 2002:a17:90b:2491:b0:33e:2d0f:4792 with SMTP id 98e67ed59e1d1-33e2d0f58cdmr5814814a91.28.1761231634351;
        Thu, 23 Oct 2025 08:00:34 -0700 (PDT)
Received: from rakuram-MSI.. ([2409:40f4:2040:16ed:f15f:ed0a:f0b7:34d2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dff3704f6sm4373510a91.2.2025.10.23.08.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 08:00:34 -0700 (PDT)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: u.kleine-koenig@baylibre.com
Cc: chenhuacai@kernel.org,
	dan.carpenter@linaro.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	lkp@intel.com,
	rakuram.e96@gmail.com,
	skhan@linuxfoundation.org,
	ulf.hansson@linaro.org,
	zhoubinbin@loongson.cn
Subject: Re: [PATCH v2] mmc: pxamci: Simplify pxamci_probe() error handling using devm APIs
Date: Thu, 23 Oct 2025 20:30:23 +0530
Message-ID: <20251023150025.167523-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: itxfh366j3yhshvp5abji6xussdk2fc7zrtvc3zzk27y5ouwpb@fvvxnpg3keu
References: <itxfh366j3yhshvp5abji6xussdk2fc7zrtvc3zzk27y5ouwpb@fvvxnpg3keus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 23 Oct 2025 at 18:28, Uwe Kleine-König <u.kleine-koenig@baylibre.com> wrote:
>
> Hello Rakuram,
>
> On Thu, Oct 23, 2025 at 05:28:17PM +0530, Rakuram Eswaran wrote:
> > On Tue, 21 Oct 2025 at 14:01, Uwe Kleine-König <u.kleine-koenig@baylibre.com> wrote:
> > > Yes, I suggest to make restructuring .remote a separate patch. (But
> > > removing dma_release_channel belongs into the patch that introduces devm
> > > to allocate the dma channels.)
> >
> > I believe ".remote" is a typo and you're referring to the _remove() function.
> > Removing if(mmc) condition check from pxamci_remove() can be handled in a
> > separate cleanup patch, while removing redundant dma_release_channel()
> > will be included in v3.
> >
> > Is my above understanding correct?
>
> ack. remote vs. remove is one of my most-committed typos :-D
>

Understood, thank you for confirming.

I've just sent the v3 patch. You can find it here:
https://lore.kernel.org/linux-mmc/20251023145432.164696-1-rakuram.e96@gmail.com/T/#u

Best Regards,
Rakuram


